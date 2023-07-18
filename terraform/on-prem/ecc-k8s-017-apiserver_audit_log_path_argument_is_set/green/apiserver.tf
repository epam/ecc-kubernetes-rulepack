resource "null_resource" "this" {

  provisioner "local-exec" {
    command     = <<CMD
      minikube ssh -- "sudo mkdir \$HOME/audit/ &&
      sudo touch  \$HOME/audit/audit.log &&
      echo -e 'apiVersion: audit.k8s.io/v1\nkind: Policy\nrules:\n- level: Metadata' |  sudo tee \$HOME/audit/audit-policy.yaml &&
      sudo sed -i '/- kube-apiserver.*/a\ \ \ \ - --audit-log-path='\$HOME'/audit/audit.log' /etc/kubernetes/manifests/kube-apiserver.yaml &&
      sudo sed -i '/- kube-apiserver.*/a\ \ \ \ - --audit-policy-file='\$HOME'/audit/audit-policy.yaml' /etc/kubernetes/manifests/kube-apiserver.yaml &&
      sudo sed -i '/volumeMounts:/a\ \ \ \ - name: audit \n\ \ \ \ \ \ mountPath: '\$HOME'/audit' /etc/kubernetes/manifests/kube-apiserver.yaml &&
      sudo sed -i '/volumes:/a\ \ - name: audit \n\ \ \ \ hostPath:\n\ \ \ \ \ \ path: '\$HOME'/audit\n\ \ \ \ \ \ type: DirectoryOrCreate' /etc/kubernetes/manifests/kube-apiserver.yaml"
    CMD
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = <<CMD
      minikube ssh -- "sudo rm -r  \$HOME/audit &&
      sudo sed -i '/audit-log-path=.*/d' /etc/kubernetes/manifests/kube-apiserver.yaml &&
      sudo sed -i '/audit-policy-file=.*/d' /etc/kubernetes/manifests/kube-apiserver.yaml &&
      sudo sed -i -e '/\- name: audit/,+1d' /etc/kubernetes/manifests/kube-apiserver.yaml &&
      sudo sed -i -e '/path: \/home\/docker\/audit/,+1d' /etc/kubernetes/manifests/kube-apiserver.yaml"
    CMD
    interpreter = ["/bin/bash", "-c"]
  }
}
