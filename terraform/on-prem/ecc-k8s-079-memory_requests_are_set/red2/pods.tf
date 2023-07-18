resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-079-red2"
    labels = {
      CustodianRule    = "ecc-k8s-079-memory_requests_are_set"
      ComplianceStatus = "Red"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-079-red2"
      resources {
        requests = {
          memory = "256Mi"
        }
      }
    }
    init_container {
      image   = "busybox"
      name    = "init-container-079-red2"
      command = ["sleep", "5"]
    }
  }
}
