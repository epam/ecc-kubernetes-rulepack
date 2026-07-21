resource "kubernetes_namespace_v1" "this" {
  metadata {
    labels = {
      CustodianRule    = "ecc-k8s-047-minimize_wildcard_use_in_roles"
      ComplianceStatus = "Green"
    }
    name = "namespace-047-green"
  }
}

resource "kubernetes_role_v1" "this1" {
  metadata {
    name      = "role-047-green1"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_role_v1" "this2" {
  metadata {
    name      = "role-047-green2"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "pods/log"]
    verbs      = ["get", "list"]
  }
  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = ["batch"]
    resources  = ["jobs"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }
}

resource "kubernetes_role_binding_v1" "this1" {
  metadata {
    name      = "role-binding-047-green1"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
    labels = {
      CustodianRule    = "ecc-k8s-047-minimize_wildcard_use_in_roles"
      ComplianceStatus = "Green"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role_v1.this1.metadata[0].name
  }

  subject {
    kind      = "User"
    name      = "jane-doe"
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "kubernetes_role_binding_v1" "this2" {
  metadata {
    name      = "role-binding-047-green2"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
    labels = {
      CustodianRule    = "ecc-k8s-047-minimize_wildcard_use_in_roles"
      ComplianceStatus = "Green"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role_v1.this2.metadata[0].name
  }

  subject {
    kind      = "User"
    name      = "john-doe"
    api_group = "rbac.authorization.k8s.io"
  }
}
