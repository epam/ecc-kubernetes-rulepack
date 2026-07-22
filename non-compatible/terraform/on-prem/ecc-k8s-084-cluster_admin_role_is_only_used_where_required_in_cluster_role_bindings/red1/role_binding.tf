resource "kubernetes_cluster_role_binding" "this" {
  metadata {
    name = "crb-084-red-1"
    labels = {
      CustodianRule    = "ecc-k8s-084-cluster_admin_role_only_used_where_required_crb"
      ComplianceStatus = "Red"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "User"
    name      = "jane-doe"
    api_group = "rbac.authorization.k8s.io"
  }
}
