resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-054-green"
    labels = {
      CustodianRule    = "ecc-k8s-054-minimize_the_admission_of_containers_which_use_hos"
      ComplianceStatus = "Green"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-054-01-green"

      port {
        container_port = 80
      }
    }
    container {
      image = "busybox:1.28"
      name  = "container-054-02-green"

      port {
        container_port = 8080
      }
      args = ["sleep", "100000"]
    }
    init_container {
      image = "busybox:1.28"
      name  = "container-054-03-green"

      port {
        container_port = 8080
      }
      args = ["sleep", "2"]
    }
  }
}