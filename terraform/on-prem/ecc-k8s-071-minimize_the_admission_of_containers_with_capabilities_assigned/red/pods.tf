resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-071-red"
    labels = {
      CustodianRule    = "ecc-k8s-071-minimize_containers_with_capabilities_assigned"
      ComplianceStatus = "Red"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-071-red"

      port {
        container_port = 80
      }
    }
  }
}