resource "kubernetes_role_v1" "this" {
  metadata {
    name = "role-087-green"
    labels = {
      CustodianRule    = "ecc-k8s-087-minimize_access_to_secrets_in_roles"
      ComplianceStatus = "Green"
    }
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["create"]

  }
}
