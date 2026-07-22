resource "kubernetes_role_binding_v1" "this" {
  metadata {
    name = "role-binding-083-red"
    labels = {
      CustodianRule    = "ecc-k8s-083-cluster_admin_role_only_used_where_required_rb"
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
