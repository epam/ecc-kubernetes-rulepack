resource "kubernetes_cluster_role_v1" "this" {
  metadata {
    name = "role-048-red"
    labels = {
      CustodianRule    = "ecc-k8s-048-minimize_wildcard_use_in_clusterroles"
      ComplianceStatus = "Red"
    }
  }

  rule {
    api_groups = ["", "extensions", "apps", "rbac.authorization.k8s.io"]
    resources  = ["pods", "*"]
    verbs      = ["get", "list", "watch"]

  }
}