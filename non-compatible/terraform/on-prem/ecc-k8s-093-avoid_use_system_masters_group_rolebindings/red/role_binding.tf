resource "kubernetes_namespace_v1" "this" {
  metadata {
    labels = {
      CustodianRule    = "ecc-k8s-093-avoid_use_system_masters_group_rolebindings"
      ComplianceStatus = "Red"
    }
    name = "namespace-093-red"
  }
}

resource "kubernetes_role_v1" "this" {
  metadata {
    name      = "role-093-red"
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
    name      = "role-binding-093-red"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
    labels = {
      CustodianRule    = "ecc-k8s-093-avoid_use_system_masters_group_rolebindings"
      ComplianceStatus = "Red"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role_v1.this.metadata[0].name
  }

  subject {
    kind      = "Group"
    name      = "system:masters"
    api_group = "rbac.authorization.k8s.io"
  }
}
