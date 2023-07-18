resource "kubernetes_role" "this" {
  metadata {
    name = "role-077-green"
    labels = {
      CustodianRule    = "ecc-k8s-077-limit_use_of_bind_impersonate_escalate_role"
      ComplianceStatus = "Green"
    }
  }

  rule {
    api_groups     = [""]
    resources      = ["pods"]
    resource_names = ["foo"]
    verbs          = ["list"]
  }
}
