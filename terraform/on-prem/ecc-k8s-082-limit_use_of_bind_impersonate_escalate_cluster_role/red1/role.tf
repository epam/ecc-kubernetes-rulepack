resource "kubernetes_cluster_role" "this" {
  metadata {
    name = "role-082-red-1"
    labels = {
      CustodianRule    = "ecc-k8s-082-limit_use_of_bind_impersonate_escalate_cl_role"
      ComplianceStatus = "Red"
    }
  }

  rule {
    api_groups = [""]
    resources  = ["namespaces", "pods"]
    verbs      = ["watch", "bind"]
  }
}
