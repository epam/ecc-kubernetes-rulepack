resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-049-red"
    labels = {
      CustodianRule    = "ecc-k8s-049-seccomp_profile_is_set_to_docker_default_in_pod"
      ComplianceStatus = "Red"
    }
  }
  spec {
    container {
      image = "nginx:1.21.6"
      name  = "container-049-red"
      port {
        container_port = 80
      }
    }
  }
}