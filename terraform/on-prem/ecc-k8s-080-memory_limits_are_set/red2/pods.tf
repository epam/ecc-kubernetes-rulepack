resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-080-red2"
    labels = {
      CustodianRule    = "ecc-k8s-080-memory_limits_are_set"
      ComplianceStatus = "Red"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-080-red2"
      resources {
        requests = {
          memory = "256Mi"
        }
        limits = {
          memory = "512Mi"
        }
      }
    }
    init_container {
      image   = "busybox"
      name    = "init-container-080-red2"
      command = ["sleep", "5"]
      resources {
        requests = {
          memory = "256Mi"
        }
      }
    }
  }
}
