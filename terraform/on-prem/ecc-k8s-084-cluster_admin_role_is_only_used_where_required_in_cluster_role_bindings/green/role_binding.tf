resource "kubernetes_cluster_role_binding" "this" {
  metadata {
    name = "crb-084-green"
    labels = {
      CustodianRule    = "ecc-k8s-084-cluster_admin_role_only_used_where_required_crb"
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
