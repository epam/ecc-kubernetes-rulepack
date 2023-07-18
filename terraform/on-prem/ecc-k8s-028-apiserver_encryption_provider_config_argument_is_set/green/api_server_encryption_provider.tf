resource "null_resource" "this" {

  provisioner "local-exec" {
    command     = "minikube ssh -- \"sudo bash -c \\\"${file("create_encryption_provider_config.sh")} \\\"\" "
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "minikube ssh -- \"sudo bash -c \\\"${file("remove_encryption_provider_config.sh")} \\\"\" "
    interpreter = ["/bin/bash", "-c"]
  }
}