resource "kubernetes_pod" "privileged_pod_056_2_red" {
  metadata {
    name = "privileged-pod-056-2-red"
  }

  spec {
    container {
      image = "nginx:latest"
      name  = "container-056-2-red"
    }

    init_container {
      image = "busybox"
      name  = "privileged-pod-056-2-red"

      security_context {
        privileged = true
      }
    }
  }
}
