resource "null_resource" "this" {

  provisioner "local-exec" {
    command     = "minikube ssh -- \"sudo bash -c \\\"${file("init_script.sh")} \\\"\" "
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "minikube ssh -- \"sudo bash -c \\\"${file("delete_script.sh")} \\\"\" "
    interpreter = ["/bin/bash", "-c"]
  }
}