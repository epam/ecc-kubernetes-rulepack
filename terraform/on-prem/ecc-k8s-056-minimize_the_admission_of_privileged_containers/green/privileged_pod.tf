resource "kubernetes_pod" "privileged_pod_056_green" {
  metadata {
    name = "privileged-pod-056-green"
  }

  spec {
    container {
      image = "nginx:latest"
      name  = "privileged-pod-056-green"
    }
  }
}
