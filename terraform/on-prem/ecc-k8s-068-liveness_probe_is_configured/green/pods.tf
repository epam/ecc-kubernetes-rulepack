resource "kubernetes_pod" "this" {
  metadata {
    name = "pod-068-green"
  }

  spec {
    container {
      image = "nginx:latest"
      name  = "pod-068-green"

      liveness_probe {
          http_get {
            path = "/"
            port = 1
          }
      }
    }
  }
}
