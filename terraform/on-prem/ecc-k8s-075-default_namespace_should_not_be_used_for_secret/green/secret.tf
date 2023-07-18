resource "kubernetes_secret_v1" "this" {
  metadata {
    name = "secret-075-green"

    labels = {
      CustodianRule    = "ecc-k8s-075-default_namespace_should_not_be_used_for_secret"
      ComplianceStatus = "Green"
    }

    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }

  data = {
    secretkey = var.secret_value
  }

}

resource "kubernetes_namespace_v1" "this" {
  metadata {
    labels = {
      CustodianRule    = "ecc-k8s-075-default_namespace_should_not_be_used_for_secret"
      ComplianceStatus = "Green"
    }
    name = "namespace-075-green"
  }
}
