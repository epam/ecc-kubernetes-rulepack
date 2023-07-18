resource "null_resource" "this" {

  provisioner "local-exec" {
    command     = "minikube ssh -- sudo sed -i \\'/- kube-controller-manager.*/a\\\\ \\\\ \\\\ \\\\ -  --terminated-pod-gc-threshold=10\\' /etc/kubernetes/manifests/kube-controller-manager.yaml"
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "minikube ssh -- sudo sed -i \\'/terminated-pod-gc-threshold=10/d\\' /etc/kubernetes/manifests/kube-controller-manager.yaml"
    interpreter = ["/bin/bash", "-c"]
  }
}
