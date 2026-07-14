resource "kubernetes_namespace_v1" "this" {
  metadata {
    labels = {
      CustodianRule    = "ecc-k8s-055-default_service_accounts_are_not_actively_used"
      ComplianceStatus = "Red"
    }
    name = "namespace-055-red"
  }
}

resource "kubernetes_role_v1" "this" {
  metadata {
    name      = "role-055-red"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_role_binding_v1" "this" {
  metadata {
    name      = "rb-055-red"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
    labels = {
      CustodianRule    = "ecc-k8s-055-default_service_accounts_are_not_actively_used"
      ComplianceStatus = "Red"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role_v1.this.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }
}
