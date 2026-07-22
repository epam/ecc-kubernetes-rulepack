resource "kubernetes_cluster_role" "this" {
  metadata {
    name = "role-084-green"
    labels = {
      CustodianRule    = "ecc-k8s-084-cluster_admin_role_only_used_where_required_crb"
      ComplianceStatus = "Green"
    }
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "this" {
  metadata {
    name = "cluster-role-binding-084-green"
    labels = {
      CustodianRule    = "ecc-k8s-084-cluster_admin_role_only_used_where_required_crb"
      ComplianceStatus = "Green"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.this.metadata[0].name
  }

  subject {
    kind      = "User"
    name      = "developer"
    api_group = "rbac.authorization.k8s.io"
  }
}
