resource "kubernetes_cluster_role_v1" "referenced_role" {
  metadata {
    name = "cr-wildcard-crb-red2-ref"
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["*"]
  }
}

resource "kubernetes_cluster_role_binding_v1" "this" {
  metadata {
    name = "crb-wildcard-red2"
    labels = {
      CustodianRule    = "cluster-role-bindings-with-wildcard-resources"
      ComplianceStatus = "Red"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.referenced_role.metadata[0].name
  }

  subject {
    kind      = "Group"
    name      = "system:authenticated"
    api_group = "rbac.authorization.k8s.io"
  }
}
