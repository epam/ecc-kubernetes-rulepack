resource "kubernetes_service_account_v1" "this" {
  metadata {
    name = "service-account-058-green"
    labels = {
      CustodianRule    = "ecc-k8s-058-sa_tokens_are_only_mounted_where_necessary"
      ComplianceStatus = "Green"
    }
  }
  automount_service_account_token = false
}