resource "null_resource" "this" {

  provisioner "local-exec" {
    command     = "minikube ssh -- sudo sed -i \\'/--bind-address=127.0.0.1/d\\' /etc/kubernetes/manifests/kube-controller-manager.yaml"
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "minikube ssh -- sudo sed -i   \\'/- kube-controller-manager/a\\\\ \\\\ \\\\ \\\\ - --bind-address=127.0.0.1\\' /etc/kubernetes/manifests/kube-controller-manager.yaml"
    interpreter = ["/bin/bash", "-c"]
  }
}