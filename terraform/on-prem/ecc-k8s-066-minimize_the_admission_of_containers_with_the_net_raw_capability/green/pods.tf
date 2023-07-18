resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-066-green"
    labels = {
      CustodianRule    = "ecc-k8s-066-minimize_containers_with_the_net_raw_capability"
      ComplianceStatus = "Green"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-066-green"

      port {
        container_port = 80
      }
    }
  }
}