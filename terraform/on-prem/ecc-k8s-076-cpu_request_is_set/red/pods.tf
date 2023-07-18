resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-076-red"
    labels = {
      CustodianRule    = "ecc-k8s-076-cpu_request_is_set"
      ComplianceStatus = "Red"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-076-red"
    }
  }
}
