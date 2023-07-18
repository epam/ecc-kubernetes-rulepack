resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-080-red"
    labels = {
      CustodianRule    = "ecc-k8s-080-memory_limits_are_set"
      ComplianceStatus = "Red"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-080-red"
    }
  }
}
