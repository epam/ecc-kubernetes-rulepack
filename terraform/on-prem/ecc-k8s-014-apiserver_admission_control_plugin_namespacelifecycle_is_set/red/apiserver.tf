resource "null_resource" "this" {

  provisioner "local-exec" {
    command     = <<CMD
      minikube ssh -- sudo sed -i \'/- kube-apiserver.*/a\\ \\ \\ \\ - --disable-admission-plugins=NamespaceLifecycle\' /etc/kubernetes/manifests/kube-apiserver.yaml
      minikube ssh -- sudo sed -i \'/- --enable-admission-plugins=.*/ s/NamespaceLifecycle,//g\' /etc/kubernetes/manifests/kube-apiserver.yaml
    CMD
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = <<CMD
      minikube ssh -- sudo sed -i \'/disable-admission-plugins=NamespaceLifecycle/d\' /etc/kubernetes/manifests/kube-apiserver.yaml
      minikube ssh -- sudo sed -i \'s/- --enable-admission-plugins=/- --enable-admission-plugins=NamespaceLifecycle,/\' /etc/kubernetes/manifests/kube-apiserver.yaml
    CMD
    interpreter = ["/bin/bash", "-c"]
  }
}
