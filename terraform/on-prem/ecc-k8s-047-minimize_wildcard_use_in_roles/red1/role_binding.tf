resource "kubernetes_namespace_v1" "this" {
  metadata {
    labels = {
      CustodianRule    = "ecc-k8s-047-minimize_wildcard_use_in_roles"
      ComplianceStatus = "Red1"
    }
    name = "namespace-047-red1"
  }
}

resource "kubernetes_role_v1" "this" {
  metadata {
    name      = "role-047-red1"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }

  rule {
    api_groups = ["", "extensions", "apps", "rbac.authorization.k8s.io"]
    resources  = ["pods", "*"]
    verbs      = ["*"]
  }
}

resource "kubernetes_role_binding_v1" "this" {
  metadata {
    name      = "role-binding-047-red1"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
    labels = {
      CustodianRule    = "ecc-k8s-047-minimize_wildcard_use_in_roles"
      ComplianceStatus = "Red1"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role_v1.this.metadata[0].name
  }

  subject {
    kind      = "User"
    name      = "jane-doe"
    api_group = "rbac.authorization.k8s.io"
  }
}
