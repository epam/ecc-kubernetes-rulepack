resource "null_resource" "this" {

  provisioner "local-exec" {
    command     = "minikube ssh -- sudo sed -i \\'/- kube-apiserver.*/a\\\\ \\\\ \\\\ \\\\ - --audit-log-maxbackup=10\\' /etc/kubernetes/manifests/kube-apiserver.yaml"
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "minikube ssh -- sudo sed -i \\'/audit-log-maxbackup=10/d\\' /etc/kubernetes/manifests/kube-apiserver.yaml"
    interpreter = ["/bin/bash", "-c"]
  }
}
