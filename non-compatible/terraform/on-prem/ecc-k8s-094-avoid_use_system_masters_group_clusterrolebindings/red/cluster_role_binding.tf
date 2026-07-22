resource "kubernetes_cluster_role_v1" "this" {
  metadata {
    name = "cluster-role-094-red"
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding_v1" "this" {
  metadata {
    name = "cluster-role-binding-094-red"
    labels = {
      CustodianRule    = "ecc-k8s-094-avoid_use_system_masters_group_crb"
      ComplianceStatus = "Red"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.this.metadata[0].name
  }

  subject {
    kind      = "Group"
    name      = "system:masters"
    api_group = "rbac.authorization.k8s.io"
  }
}
