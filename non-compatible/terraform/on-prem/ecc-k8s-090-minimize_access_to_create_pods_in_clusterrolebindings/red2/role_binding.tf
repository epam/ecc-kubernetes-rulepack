resource "kubernetes_cluster_role_v1" "referenced_role" {
  metadata {
    name = "role-090-red2"
  }

  rule {
    api_groups = [""]
    resources  = ["*"]
    verbs      = ["create", "list"]
  }
}

resource "kubernetes_cluster_role_binding_v1" "this" {
  metadata {
    name = "cluster-role-binding-090-red2"
    labels = {
      CustodianRule    = "ecc-k8s-090-minimize_access_to_create_pods_in_crb"
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
