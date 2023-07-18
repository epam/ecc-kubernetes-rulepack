resource "null_resource" "this" {
  provisioner "local-exec" {
    command     = "minikube ssh -- sudo sed -i  \\'/- kube-apiserver/a\\\\ \\\\ \\\\ \\\\ - --anonymous-auth=true\\' /etc/kubernetes/manifests/kube-apiserver.yaml"
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "minikube ssh -- sudo sed -i \\'/--anonymous-auth=true/d\\' /etc/kubernetes/manifests/kube-apiserver.yaml"
    interpreter = ["/bin/bash", "-c"]
  }
}