resource "kubernetes_pod" "this" {
  metadata {
    name = "pod-069-red"
  }

  spec {
    container {
      image = "nginx:latest"
      name  = "pod-069-red"
    }
  }
}
