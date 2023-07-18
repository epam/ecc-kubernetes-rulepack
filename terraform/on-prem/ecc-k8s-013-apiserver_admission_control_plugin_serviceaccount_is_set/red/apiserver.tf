resource "null_resource" "this" {

  provisioner "local-exec" {
    command     = <<CMD
      minikube ssh -- sudo sed -i \'/- kube-apiserver.*/a\\ \\ \\ \\ - --disable-admission-plugins=ServiceAccount\' /etc/kubernetes/manifests/kube-apiserver.yaml
      minikube ssh -- sudo sed -i \'/- --enable-admission-plugins=.*/ s/,ServiceAccount//g\' /etc/kubernetes/manifests/kube-apiserver.yaml
    CMD
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = <<CMD
      minikube ssh -- sudo sed -i \'/disable-admission-plugins=ServiceAccount/d\' /etc/kubernetes/manifests/kube-apiserver.yaml
      minikube ssh -- sudo sed -i \'/- --enable-admission-plugins=.*/ s/$/,ServiceAccount/\' /etc/kubernetes/manifests/kube-apiserver.yaml
    CMD
    interpreter = ["/bin/bash", "-c"]
  }
}
