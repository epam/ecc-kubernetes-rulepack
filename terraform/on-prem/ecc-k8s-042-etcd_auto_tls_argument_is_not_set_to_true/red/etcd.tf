resource "null_resource" "this" {

  provisioner "local-exec" {
    command     = "minikube ssh -- sudo sed -i \\'/- etcd.*/a\\\\ \\\\ \\\\ \\\\ - --auto-tls=true\\' /etc/kubernetes/manifests/etcd.yaml"
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "minikube ssh -- sudo sed -i \\'/--auto-tls=true/d\\' /etc/kubernetes/manifests/etcd.yaml"
    interpreter = ["/bin/bash", "-c"]
  }
}