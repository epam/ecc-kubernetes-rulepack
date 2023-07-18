resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-066-red3"
    labels = {
      CustodianRule    = "ecc-k8s-066-minimize_containers_with_the_net_raw_capability"
      ComplianceStatus = "Red"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-066-red3"

      port {
        container_port = 80
      }
    }

    init_container {
      image   = "busybox"
      name    = "init-container-066-red3"
      command = ["sleep", "5"]

      security_context {
        capabilities {
          add = ["NET_RAW"]
        }
      }
    }
  }
}