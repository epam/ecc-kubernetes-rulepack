resource "kubernetes_role_binding_v1" "this" {
  metadata {
    name = "rb-cluster-admin-red-2"
    labels = {
      CustodianRule    = "cluster_admin_role_is_only_used_where_required_in_cluster_role_bindings"
      ComplianceStatus = "Red"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = "kube-system"
  }
}
