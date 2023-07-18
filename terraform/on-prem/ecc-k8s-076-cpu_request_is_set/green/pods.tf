resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-076-green"
    labels = {
      CustodianRule    = "ecc-k8s-076-cpu_request_is_set"
      ComplianceStatus = "Green"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-076-green"

      resources {
        requests = {
          cpu = "200m"
        }
      }
    }
  }
}
