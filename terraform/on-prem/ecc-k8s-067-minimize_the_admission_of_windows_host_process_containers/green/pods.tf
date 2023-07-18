resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-067-green"
    labels = {
      CustodianRule    = "ecc-k8s-067-minimize_the_admission_of_containers_with_added"
      ComplianceStatus = "Green"
    }
  }
  spec {
    host_network = true
    container {
      image  = "nginx:1.21.6"
      name   = "container-067-green"
      security_context {
        capabilities {
          drop = ["ALL"]
        }
      }
      port {
        container_port = 80
      }
    }
  }
}
