resource "null_resource" "this" {

  provisioner "local-exec" {
    command     = "minikube ssh -- sudo sed -i \\'/- kube-apiserver.*/a\\\\ \\\\ \\\\ \\\\ - --service-account-lookup=false\\' /etc/kubernetes/manifests/kube-apiserver.yaml"
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "minikube ssh -- sudo sed -i \\'/service-account-lookup=false/d\\' /etc/kubernetes/manifests/kube-apiserver.yaml"
    interpreter = ["/bin/bash", "-c"]
  }
}
