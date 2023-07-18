resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-086-red3"
    labels = {
      CustodianRule    = "ecc-k8s-086-apply_security_context_to_your_pods_and_containers"
      ComplianceStatus = "Red"
    }
  }

  spec {
    security_context {
      seccomp_profile {
        type = "RuntimeDefault"
      }
    }

    container {
      image = "nginx"
      name  = "container-086-red3"

      port {
        container_port = 80
      }

      security_context {
        privileged = false
      }
    }

    init_container {
      image   = "busybox"
      name    = "init-container-086-red3"
      command = ["sleep", "5"]
    }
  }
}
