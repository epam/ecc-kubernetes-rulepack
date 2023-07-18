resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-054-red1"
    labels = {
      CustodianRule    = "ecc-k8s-054-minimize_the_admission_of_containers_which_use_hos"
      ComplianceStatus = "Red1"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-054-01-red1"
      port {
        container_port = 80
      }
    }
    init_container {
      image = "busybox:1.28"
      name  = "container-054-02-red1"

      port {
        container_port = 8080
        host_port      = 8080
      }
      args = ["sleep", "2"]
    }
    init_container {
      image = "busybox:1.28"
      name  = "container-054-02-red2"

      port {
        container_port = 8081
        host_port      = 8081
      }
      args = ["sleep", "3"]
    }
  }
}