
resource "kubernetes_config_map_v1" "this" {
  metadata {
    name = "configmap-051-red"
    labels = {
      CustodianRule    = "ecc-k8s-051-default_namespace_should_not_be_used_for_configmap"
      ComplianceStatus = "Red"
    }
  }
  data = {
    red-data-key = "red"
  }
}