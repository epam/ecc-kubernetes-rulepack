resource "kubernetes_role_v1" "this" {
  metadata {
    name = "role-053-green"
    labels = {
      CustodianRule    = "ecc-k8s-053-default_namespace_should_not_be_used_for_role"
      ComplianceStatus = "Green"
    }
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }
  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_namespace_v1" "this" {
  metadata {
    labels = {
      CustodianRule    = "ecc-k8s-053-default_namespace_should_not_be_used_for_role"
      ComplianceStatus = "Green"
    }
    name = "namespace-053-green"
  }
}
