resource "kubernetes_role" "this" {
  metadata {
    name = "role-083-red-1"
    labels = {
      CustodianRule    = "ecc-k8s-083-minimize_access_to_create_pods"
      ComplianceStatus = "Red"
    }
  }

  rule {
    api_groups     = [""]
    resources      = ["pods"]
    resource_names = ["foo"]
    verbs          = ["create", "list"]
  }
}
