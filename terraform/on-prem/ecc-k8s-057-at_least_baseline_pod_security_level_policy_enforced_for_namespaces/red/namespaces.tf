resource "kubernetes_namespace_v1" "this" {
  metadata {
    labels = {
      CustodianRule    = "ecc-k8s-057-at_least_baseline_pod_security_level_policy_enforc"
      ComplianceStatus = "Red"
    }
    name = "namespace-057-red"
  }
}
