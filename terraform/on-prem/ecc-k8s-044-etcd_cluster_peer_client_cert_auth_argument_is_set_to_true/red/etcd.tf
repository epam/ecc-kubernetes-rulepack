resource "null_resource" "this" {

  provisioner "local-exec" {
    command     = "minikube ssh -- sudo sed -i \\'s/--peer-client-cert-auth=true/--peer-client-cert-auth=false/\\' /etc/kubernetes/manifests/etcd.yaml"
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "minikube ssh -- sudo sed -i \\'s/--peer-client-cert-auth=false/--peer-client-cert-auth=true/\\' /etc/kubernetes/manifests/etcd.yaml"
    interpreter = ["/bin/bash", "-c"]
  }
}
