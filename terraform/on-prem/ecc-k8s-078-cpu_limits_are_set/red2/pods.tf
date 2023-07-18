resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-078-red2"
    labels = {
      CustodianRule    = "ecc-k8s-078-cpu_limits_are_set"
      ComplianceStatus = "Red"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-078-red2"
      resources {
        requests = {
          cpu = "200m"
        }
        limits = {
          cpu = "300m"
        }
      }
    }
    init_container {
      image   = "busybox"
      name    = "init-container-078-red2"
      command = ["sleep", "5"]
      resources {
        requests = {
          cpu = "200m"
        }
      }
    }
  }
}
