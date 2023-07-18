resource "null_resource" "this" {
  provisioner "local-exec" {
    command     = "minikube ssh -- sudo sed -i  \\'/- kube-apiserver/a\\\\ \\\\ \\\\ \\\\ - --kubelet-certificate-authority=/var/lib/minikube/certs/ca.crt\\' /etc/kubernetes/manifests/kube-apiserver.yaml"
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "minikube ssh -- sudo sed -i \\'/--kubelet-certificate-authority=/d\\' /etc/kubernetes/manifests/kube-apiserver.yaml"
    interpreter = ["/bin/bash", "-c"]
  }
}