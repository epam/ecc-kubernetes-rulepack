resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-078-green"
    labels = {
      CustodianRule    = "ecc-k8s-078-cpu_limits_are_set"
      ComplianceStatus = "Green"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-078-green"

      resources {
        requests = {
          cpu = "200m"
        }
        limits = {
          cpu = "300m"
        }
      }
    }
  }
}
