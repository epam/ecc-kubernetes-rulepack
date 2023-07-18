resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-067-red"
    labels = {
      CustodianRule    = "ecc-k8s-067-minimize_the_admission_of_containers_with_added"
      ComplianceStatus = "Red"
    }
  }
  spec {
    container {
      image  = "nginx:1.21.6"
      name   = "container-067-red"
      security_context {
        capabilities {
          add = ["ALL"]
        }
      }
      port {
        container_port = 80
      }
    }
  }
}
