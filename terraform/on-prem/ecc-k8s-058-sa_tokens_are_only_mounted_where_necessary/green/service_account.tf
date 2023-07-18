resource "null_resource" "this" {

  provisioner "local-exec" {
    command     = "sudo apt install -y jq && kubectl get serviceaccounts --all-namespaces -o json |   jq '.items[].automountServiceAccountToken = false' | kubectl apply -f -"
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "kubectl get serviceaccounts --all-namespaces -o json |   jq '.items[].automountServiceAccountToken = true' |   kubectl apply -f -"
    interpreter = ["/bin/bash", "-c"]
  }
}