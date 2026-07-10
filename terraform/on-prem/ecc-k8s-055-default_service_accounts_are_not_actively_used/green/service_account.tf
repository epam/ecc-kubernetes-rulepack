resource "kubernetes_namespace_v1" "this" {
  metadata {
    labels = {
      CustodianRule    = "ecc-k8s-055-default_service_accounts_are_not_actively_used"
      ComplianceStatus = "Green"
    }
    name = "namespace-055-green"
  }
}

resource "kubernetes_default_service_account_v1" "this" {
  metadata {
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }
  automount_service_account_token = false
}
