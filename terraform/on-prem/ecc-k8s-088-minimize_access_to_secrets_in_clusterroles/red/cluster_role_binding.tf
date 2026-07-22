resource "kubernetes_cluster_role_v1" "referenced_role" {
  metadata {
    name = "role-088-red"
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding_v1" "this" {
  metadata {
    name = "cluster-role-binding-088-red"
    labels = {
      CustodianRule    = "ecc-k8s-088-minimize_access_to_secrets_in_clusterroles"
      ComplianceStatus = "Red"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.referenced_role.metadata[0].name
  }

  subject {
    kind      = "User"
    name      = "jane-doe"
    api_group = "rbac.authorization.k8s.io"
  }
}
