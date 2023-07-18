resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-079-green"
    labels = {
      CustodianRule    = "ecc-k8s-079-memory_requests_are_set"
      ComplianceStatus = "Green"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-079-green"

      resources {
        requests = {
          memory = "256Mi"
        }
      }
    }
  }
}
