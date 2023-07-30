resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-067-red1"
    labels = {
      CustodianRule    = "ecc-k8s-067-minimize_the_admission_of_containers_with_added"
      ComplianceStatus = "Red1"
    }
  }
  spec {
    container {
      image  = "nginx:1.21.6"
      name   = "container-067-red1"
      security_context {
        capabilities {
          drop = ["ALL"]
        }
      }
      port {
        container_port = 80
      }
    }
    init_container {
      image  = "busybox"
      name   = "init-container-067-red1"
      command = ["sleep", "5"]
      security_context {
        capabilities {
          add = ["ALL"]
        }
      }
    }
  }
}
