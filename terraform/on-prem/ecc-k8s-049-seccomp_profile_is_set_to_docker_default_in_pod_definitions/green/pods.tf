resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-049-green"
    labels = {
      CustodianRule    = "ecc-k8s-049-seccomp_profile_is_set_to_docker_default_in_pod"
      ComplianceStatus = "Green"
    }
  }
  spec {
    security_context {
      seccomp_profile {
        type = "RuntimeDefault"
      }
    }
    container {
      image = "nginx:1.21.6"
      name  = "container-049-green"
      port {
        container_port = 80
      }
    }
  }
}