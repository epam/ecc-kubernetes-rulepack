resource "kubernetes_role_v1" "referenced_role" {
  metadata {
    name = "role-wildcard-rb-green-ref"
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_role_binding_v1" "this" {
  metadata {
    name = "rb-wildcard-green"
    labels = {
      CustodianRule    = "role-bindings-with-wildcard-resources"
      ComplianceStatus = "Green"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role_v1.referenced_role.metadata[0].name
  }

  subject {
    kind      = "Group"
    name      = "system:authenticated"
    api_group = "rbac.authorization.k8s.io"
  }
}
