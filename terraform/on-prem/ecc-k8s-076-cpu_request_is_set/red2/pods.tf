resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-076-red2"
    labels = {
      CustodianRule    = "ecc-k8s-076-cpu_request_is_set"
      ComplianceStatus = "Red"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-076-red2"
      resources {
        requests = {
          cpu = "200m"
        }
      }
    }
    init_container {
      image   = "busybox"
      name    = "init-container-076-red2"
      command = ["sleep", "5"]
    }
  }
}
