resource "kubernetes_secret_v1" "this" {
  metadata {
    name = "secret-075-red"

    labels = {
      CustodianRule    = "ecc-k8s-075-default_namespace_should_not_be_used_for_secret"
      ComplianceStatus = "Red"
    }

  }

  data = {
    secretkey = var.secret_value
  }

}
