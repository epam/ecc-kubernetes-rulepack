resource "kubernetes_cluster_role_v1" "referenced_role" {
  metadata {
    name = "cr-wildcard-crb-green-ref"
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding_v1" "this" {
  metadata {
    name = "crb-wildcard-green"
    labels = {
      CustodianRule    = "cluster-role-bindings-with-wildcard-resources"
      ComplianceStatus = "Green"
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
