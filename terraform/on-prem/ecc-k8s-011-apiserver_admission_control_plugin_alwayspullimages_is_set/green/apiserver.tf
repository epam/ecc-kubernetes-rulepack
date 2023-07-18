resource "null_resource" "this" {

  provisioner "local-exec" {
    command     = "minikube ssh -- sudo sed -i  \\'/- --enable-admission-plugins=.*/ s/$/,AlwaysPullImages/\\' /etc/kubernetes/manifests/kube-apiserver.yaml"
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "minikube ssh -- sudo sed -i \\'/- --enable-admission-plugins=.*/ s/,AlwaysPullImages//g\\' /etc/kubernetes/manifests/kube-apiserver.yaml"
    interpreter = ["/bin/bash", "-c"]
  }
}