resource "kubernetes_role_v1" "this" {
  metadata {
    name = "role-053-red"
    labels = {
      CustodianRule    = "ecc-k8s-053-default_namespace_should_not_be_used_for_role"
      ComplianceStatus = "Red"
    }
  }
  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list", "watch"]
  }
}
