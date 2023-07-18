resource "null_resource" "this" {
  provisioner "local-exec" {
    command     = "minikube ssh -- sudo sed -E -i \\'/kubelet-client-certificate\\|kubelet-client-key/d\\' /etc/kubernetes/manifests/kube-apiserver.yaml"
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "minikube ssh -- sudo sed -i  \\'/- kube-apiserver/a\\\\ \\\\ \\\\ \\\\ - --kubelet-client-certificate=/var/lib/minikube/certs/apiserver-kubelet-client.crt\\\\n\\\\ \\\\ \\\\ \\\\ - --kubelet-client-key=/var/lib/minikube/certs/apiserver-kubelet-client.key\\' /etc/kubernetes/manifests/kube-apiserver.yaml"
    interpreter = ["/bin/bash", "-c"]
  }
}
