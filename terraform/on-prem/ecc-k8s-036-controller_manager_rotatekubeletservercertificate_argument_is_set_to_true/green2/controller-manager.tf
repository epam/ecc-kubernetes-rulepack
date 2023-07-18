resource "null_resource" "this" {

  provisioner "local-exec" {
    command     = "minikube ssh -- sudo sed -i \\'/- kube-controller-manager.*/a\\\\ \\\\ \\\\ \\\\ - --feature-gates=RotateKubeletServerCertificate=true\\' /etc/kubernetes/manifests/kube-controller-manager.yaml"
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "minikube ssh -- sudo sed -i \\'/feature-gates=RotateKubeletServerCertificate=true/d\\' /etc/kubernetes/manifests/kube-controller-manager.yaml"
    interpreter = ["/bin/bash", "-c"]
  }
}
