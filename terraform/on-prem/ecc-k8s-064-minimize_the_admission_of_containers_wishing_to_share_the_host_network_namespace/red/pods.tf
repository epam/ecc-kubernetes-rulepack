resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-064-red"
    labels = {
      CustodianRule    = "ecc-k8s-064-minimize_the_admission_of_containers_wishing"
      ComplianceStatus = "Red"
    }
  }
  spec {
    host_network = true
    container {
      image  = "nginx:1.21.6"
      name   = "container-064-red"
      port {
        container_port = 80
      }
    }
  }
}
