resource "null_resource" "this" {

  provisioner "local-exec" {
    command     = <<CMD
      cat <<EOF > temp-01.json
{
"spec": {
    "unsupportedConfigOverrides": {
         "apiServerArguments": {
             "basic-auth-file": [
                 "/etc/kubernetes/basic_auth.csv"
                ]
            }
        }
    }
}
EOF

    kubectl patch kubeapiserver cluster -n openshift-kube-apiserver-operator --patch-file temp-01.json --type merge
    rm temp-01.json
    CMD
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = <<CMD
      cat <<EOF > temp-01.json
{
"spec": {
    "unsupportedConfigOverrides": null
    }
}
EOF
    kubectl patch kubeapiserver cluster -n openshift-kube-apiserver-operator --patch-file temp-01.json --type merge
    rm temp-01.json
    CMD
    interpreter = ["/bin/bash", "-c"]
  }
}
