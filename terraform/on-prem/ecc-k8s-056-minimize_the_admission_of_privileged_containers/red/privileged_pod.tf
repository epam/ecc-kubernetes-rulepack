resource "kubernetes_pod" "privileged_pod_056_red" {
  metadata {
    name = "privileged-pod-056-red"
  }

  spec {
    container {
      image = "nginx:latest"
      name  = "privileged-pod-056-red"

      security_context {
        privileged = true
      }
    }
  }
}
