resource "null_resource" "this" {

  provisioner "local-exec" {
    command = "minikube ssh -- sudo sed -i  \\'/- --enable-admission-plugins=.*/ s/$/,DenyServiceExternalIPs/\\' /etc/kubernetes/manifests/kube-apiserver.yaml"
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when    = destroy
    command = "minikube ssh -- sudo sed -i \\'s/,DenyServiceExternalIPs//g\\' /etc/kubernetes/manifests/kube-apiserver.yaml"
    interpreter = ["/bin/bash", "-c"]
  }
}
