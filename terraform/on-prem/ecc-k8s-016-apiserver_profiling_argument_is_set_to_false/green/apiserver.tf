resource "null_resource" "this" {

  provisioner "local-exec" {
    command     = "minikube ssh -- sudo sed -i \\'/- kube-apiserver.*/a\\\\ \\\\ \\\\ \\\\ - --profiling=false\\' /etc/kubernetes/manifests/kube-apiserver.yaml"
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "minikube ssh -- sudo sed -i \\'/--profiling=false/d\\' /etc/kubernetes/manifests/kube-apiserver.yaml"
    interpreter = ["/bin/bash", "-c"]
  }
}
