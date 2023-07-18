resource "kubernetes_role_v1" "this1" {
  metadata {
    name = "role-047-green1"
    labels = {
      CustodianRule    = "ecc-k8s-047-minimize_wildcard_use_in_roles"
      ComplianceStatus = "Green"
    }
  }
  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_role_v1" "this2" {
  metadata {
    name = "role-047-green2"
    labels = {
      CustodianRule    = "ecc-k8s-047-minimize_wildcard_use_in_roles"
      ComplianceStatus = "Green"
    }
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


