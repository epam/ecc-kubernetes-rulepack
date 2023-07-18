resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-065-green"
    labels = {
      CustodianRule    = "ecc-k8s-065-minimize_the_admission_of_containers_wishing"
      ComplianceStatus = "Green"
    }
  }
  spec {
    host_pid = false
    container {
      image  = "nginx:1.21.6"
      name   = "container-065-green"
      port {
        container_port = 80
      }
    }
  }
}
