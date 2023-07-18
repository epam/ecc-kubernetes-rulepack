resource "kubernetes_role" "this" {
  metadata {
    name = "role-077-red-1"
    labels = {
      CustodianRule    = "ecc-k8s-077-limit_use_of_bind_impersonate_escalate_role"
      ComplianceStatus = "Red"
    }
  }

  rule {
    api_groups     = [""]
    resources      = ["pods"]
    resource_names = ["foo"]
    verbs          = ["bind", "list"]
  }
}
