resource "kubernetes_cluster_role_v1" "this" {
  metadata {
    name = "role-048-red2"
    labels = {
      CustodianRule    = "ecc-k8s-048-minimize_wildcard_use_in_clusterroles"
      ComplianceStatus = "Red2"
    }
  }
  rule {
    non_resource_urls = ["/healthz", "*"]
    verbs             = ["get", "*"]
  }
  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = ["batch"]
    resources  = ["jobs"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }
}
