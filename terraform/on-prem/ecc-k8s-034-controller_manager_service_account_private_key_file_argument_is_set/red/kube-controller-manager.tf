resource "null_resource" "this" {

  provisioner "local-exec" {
    command     = <<CMD
      minikube ssh -- sudo sed -i \'/.*- --service-account-private-key-file=.*/d\' /etc/kubernetes/manifests/kube-controller-manager.yaml
    CMD
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = <<CMD
      minikube ssh -- sudo sed -i \'/- kube-controller-manager/a\\ \\ \\ \\ - --service-account-private-key-file=/var/lib/minikube/certs/sa.key\' /etc/kubernetes/manifests/kube-controller-manager.yaml
    CMD
    interpreter = ["/bin/bash", "-c"]
  }
}
