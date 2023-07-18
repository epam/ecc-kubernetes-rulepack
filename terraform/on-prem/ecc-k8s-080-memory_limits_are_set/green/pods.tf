resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-080-green"
    labels = {
      CustodianRule    = "ecc-k8s-080-memory_limits_are_set"
      ComplianceStatus = "Green"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-080-green"

      resources {
        requests = {
          memory = "256Mi"
        }
        limits = {
          memory = "512Mi"
        }
      }
    }
  }
}
