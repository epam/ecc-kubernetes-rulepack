resource "kubernetes_cluster_role_v1" "this" {
  metadata {
    name = "role-088-green"
    labels = {
      CustodianRule    = "ecc-k8s-088-minimize_access_to_secrets_in_clusterroles"
      ComplianceStatus = "Green"
    }
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["create"]
  }
}
