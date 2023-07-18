resource "kubernetes_role_v1" "this" {
  metadata {
    name = "role-047-red"
    labels = {
      CustodianRule    = "ecc-k8s-047-minimize_wildcard_use_in_roles"
      ComplianceStatus = "Red"
    }
  }
  rule {
    api_groups = ["", "extensions", "apps", "rbac.authorization.k8s.io"]
    resources  = ["*"]
    verbs      = ["get", "list", "watch"]
  }
}


