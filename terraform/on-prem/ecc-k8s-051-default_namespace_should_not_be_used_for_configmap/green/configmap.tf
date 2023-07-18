resource "kubernetes_config_map_v1" "this" {
  metadata {
    name      = "configmap-051-green"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
    labels = {
      CustodianRule    = "ecc-k8s-051-default_namespace_should_not_be_used_for_configmap"
      ComplianceStatus = "Green"
    }
  }
  data = {
    green-data-key = "green"
  }
}

resource "kubernetes_namespace_v1" "this" {
  metadata {
    labels = {
      CustodianRule    = "ecc-k8s-051-default_namespace_should_not_be_used_for_configmap"
      ComplianceStatus = "Green"
    }
    name = "namespace-051-green"
  }
}
