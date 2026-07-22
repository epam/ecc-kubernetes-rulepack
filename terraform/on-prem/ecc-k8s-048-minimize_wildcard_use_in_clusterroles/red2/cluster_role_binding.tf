resource "kubernetes_cluster_role_v1" "this" {
  metadata {
    name = "role-048-red2"
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

resource "kubernetes_cluster_role_binding_v1" "this" {
  metadata {
    name = "cluster-role-binding-048-red2"
    labels = {
      CustodianRule    = "ecc-k8s-048-minimize_wildcard_use_in_clusterroles"
      ComplianceStatus = "Red2"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.this.metadata[0].name
  }

  subject {
    kind      = "User"
    name      = "jane-doe"
    api_group = "rbac.authorization.k8s.io"
  }
}
