#!/bin/bash -ex
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

apt update && apt upgrade -y
apt install unzip 

echo "[TASK 1] Disable and turn off SWAP"
sed -i '/swap/d' /etc/fstab
swapoff -a

echo "[TASK 2] Stop and Disable firewall"
systemctl disable --now ufw >/dev/null 2>&1

echo "[TASK 3] Enable and Load Kernel modules"
cat >>/etc/modules-load.d/containerd.conf<<EOF
overlay
br_netfilter
EOF
modprobe overlay
modprobe br_netfilter

echo "[TASK 4] Add Kernel settings"
cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
EOF
sysctl --system >/dev/null 2>&1

echo "[TASK 5] Install containerd runtime"
apt update -qq >/dev/null 2>&1
apt install -qq -y containerd apt-transport-https >/dev/null 2>&1
mkdir /etc/containerd
containerd config default > /etc/containerd/config.toml
sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
systemctl restart containerd
systemctl enable containerd >/dev/null 2>&1

echo "[TASK 6] Add apt repo for kubernetes"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - >/dev/null 2>&1
apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main" >/dev/null 2>&1

echo "[TASK 7] Install Kubernetes components (kubeadm, kubelet and kubectl)"
apt install -qq -y kubeadm=1.25.3-00 kubelet=1.25.3-00 kubectl=1.25.3-00 >/dev/null 2>&1

echo "[TASK 8] Enable ssh password authentication"
sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd

echo "[TASK 9] Create kubeadmin user"
echo -e "kubeadmin\nkubeadmin" | passwd ubuntu
echo "alias k=kubectl" >> /etc/bash.bashrc

echo "[TASK 10] Install AWS CLI and Terraform"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip >/dev/null 2>&1
sudo ./aws/install >/dev/null 2>&1

sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform

echo "[TASK 11] Pull required containers"
kubeadm config images pull >/dev/null 2>&1

echo "[TASK 12] Initialize Kubernetes Cluster"
kubeadm init --pod-network-cidr=10.244.0.0/16 >> /root/kubeinit.log 2>/dev/null
export KUBECONFIG=/etc/kubernetes/admin.conf
sudo  -H -u ubuntu bash -c 'mkdir -p $HOME/.kube'
sudo  -H -u ubuntu bash -c 'sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config'
sudo  -H -u ubuntu bash -c 'sudo chown $(id -u):$(id -g) $HOME/.kube/config'
kubeadm token create --print-join-command > /joincluster.ps1
echo "`cat /joincluster.ps1` --cri-socket \"npipe:////./pipe/containerd-containerd\" --ignore-preflight-errors=IsPrivilegedUser *>> c:\kubeadm.log" > /joincluster.ps1

echo "[TASK 13] Download scripts"
sudo  -H -u ubuntu bash -c 'aws s3 cp s3://${bucket}/ /home/ubuntu/ --recursive --exclude "*.ps1" &> /home/ubuntu/logs.log'

echo "[TASK 14] Apply the Flannel manifest and validate"
sudo  -H -u ubuntu bash -c 'kubectl apply -f /home/ubuntu/kube-flannel.yaml &>> /home/ubuntu/logs.log'

kube_flannel_ds="$(kubectl get pods -l app=flannel -n kube-flannel --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')"
echo $kube_flannel_ds
while [[ $(kubectl get pods $kube_flannel_ds -n kube-flannel -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do
  echo "sleep for 3s"
  sleep 3
done

echo "[TASK 15] Add Windows Flannel and kube-proxy DaemonSets"
sudo  -H -u ubuntu bash -c 'kubectl apply -f /home/ubuntu/kube-proxy.yaml &>> /home/ubuntu/logs.log'
sudo  -H -u ubuntu bash -c 'kubectl apply -f /home/ubuntu/flannel-overlay.yaml &>> /home/ubuntu/logs.log'
sudo  -H -u ubuntu bash -c 'kubectl apply -f /home/ubuntu/kube-flannel-rbac.yaml &>> /home/ubuntu/logs.log'
