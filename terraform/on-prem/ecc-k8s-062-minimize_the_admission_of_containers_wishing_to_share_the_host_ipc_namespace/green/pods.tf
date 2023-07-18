resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-062-green"
    labels = {
      CustodianRule    = "ecc-k8s-062-minimize_the_admission_of_containers_wishing"
      ComplianceStatus = "Green"
    }
  }
  spec {
    host_ipc = false
    container {
      image  = "nginx:1.21.6"
      name   = "container-062-green"
      port {
        container_port = 80
      }
    }
  }
}
