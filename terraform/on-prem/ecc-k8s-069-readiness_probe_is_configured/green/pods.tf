resource "kubernetes_pod" "this" {
  metadata {
    name = "pod-069-green"
  }

  spec {
    container {
      image = "nginx:latest"
      name  = "pod-069-green"

      readiness_probe {
        http_get {
          path = "/health"
          port = 8080
        }
        initial_delay_seconds = 30
        timeout_seconds = 10
        period_seconds = 10
        failure_threshold = 3
      }
    }
  }
}
