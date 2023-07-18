
resource "null_resource" "this" {

  provisioner "local-exec" {
    command     = "minikube ssh -- sudo sed -i   \\'/- kube-scheduler/a\\\\ \\\\ \\\\ \\\\ - --profiling=false\\' /etc/kubernetes/manifests/kube-scheduler.yaml"
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "minikube ssh -- sudo sed -i \\'/--profiling=false/d\\' /etc/kubernetes/manifests/kube-scheduler.yaml"
    interpreter = ["/bin/bash", "-c"]
  }
}