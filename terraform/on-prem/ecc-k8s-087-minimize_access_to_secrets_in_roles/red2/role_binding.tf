resource "kubernetes_namespace_v1" "this" {
  metadata {
    labels = {
      CustodianRule    = "ecc-k8s-087-minimize_access_to_secrets_in_roles"
      ComplianceStatus = "Red"
    }
    name = "namespace-087-red2"
  }
}

resource "kubernetes_role_v1" "referenced_role" {
  metadata {
    name      = "role-087-red2"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }

  rule {
    api_groups = [""]
    resources  = ["*"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_role_binding_v1" "this" {
  metadata {
    name      = "role-binding-087-red2"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
    labels = {
      CustodianRule    = "ecc-k8s-087-minimize_access_to_secrets_in_roles"
      ComplianceStatus = "Red"
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
