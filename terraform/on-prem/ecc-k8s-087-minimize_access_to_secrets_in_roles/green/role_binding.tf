resource "kubernetes_namespace_v1" "this" {
  metadata {
    labels = {
      CustodianRule    = "ecc-k8s-087-minimize_access_to_secrets_in_roles"
      ComplianceStatus = "Green"
    }
    name = "namespace-087-green"
  }
}

resource "kubernetes_role_v1" "referenced_role" {
  metadata {
    name      = "role-087-green"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["create"]
  }
}

resource "kubernetes_role_binding_v1" "this" {
  metadata {
    name      = "role-binding-087-green"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
    labels = {
      CustodianRule    = "ecc-k8s-087-minimize_access_to_secrets_in_roles"
      ComplianceStatus = "Green"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role_v1.referenced_role.metadata[0].name
  }

  subject {
    kind      = "User"
    name      = "jane-doe"
    api_group = "rbac.authorization.k8s.io"
  }
}
