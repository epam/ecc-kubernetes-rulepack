resource "kubernetes_role_binding_v1" "this" {
  metadata {
    name = "rb-cluster-admin-green"
    labels = {
      CustodianRule    = "cluster_admin_role_only_used_where_required_rb"
      ComplianceStatus = "Green"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "Group"
    name      = "system:masters"
    api_group = "rbac.authorization.k8s.io"
  }
}
