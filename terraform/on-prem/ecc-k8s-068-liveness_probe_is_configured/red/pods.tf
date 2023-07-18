resource "kubernetes_pod" "this" {
  metadata {
    name = "pod-068-red"
  }

  spec {
    container {
      image = "nginx:latest"
      name  = "pod-068-red"
    }
  }
}
