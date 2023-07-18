resource "kubernetes_cluster_role_v1" "this" {
  metadata {
    name = "role-088-red"
    labels = {
      CustodianRule    = "ecc-k8s-088-minimize_access_to_secrets_in_clusterroles"
      ComplianceStatus = "Red"
    }
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["get", "list", "watch"]

  }
}