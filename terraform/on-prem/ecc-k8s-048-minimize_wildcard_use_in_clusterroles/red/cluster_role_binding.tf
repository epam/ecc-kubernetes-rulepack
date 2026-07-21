resource "kubernetes_cluster_role_v1" "this" {
  metadata {
    name = "role-048-red"
  }

  rule {
    api_groups = ["", "extensions", "apps", "rbac.authorization.k8s.io"]
    resources  = ["pods", "*"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding_v1" "this" {
  metadata {
    name = "cluster-role-binding-048-red"
    labels = {
      CustodianRule    = "ecc-k8s-048-minimize_wildcard_use_in_clusterroles"
      ComplianceStatus = "Red"
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
