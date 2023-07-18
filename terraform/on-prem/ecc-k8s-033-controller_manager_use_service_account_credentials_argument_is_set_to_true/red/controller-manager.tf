resource "null_resource" "this" {

  provisioner "local-exec" {
    command     = "minikube ssh -- sudo sed -i \\'s/--use-service-account-credentials=true/--use-service-account-credentials=false/\\' /etc/kubernetes/manifests/kube-controller-manager.yaml"                                            
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "minikube ssh -- sudo sed -i \\'s/--use-service-account-credentials=false/--use-service-account-credentials=true/\\' /etc/kubernetes/manifests/kube-controller-manager.yaml"
    interpreter = ["/bin/bash", "-c"]
  }


}
