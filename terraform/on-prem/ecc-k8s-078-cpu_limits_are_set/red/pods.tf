resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-078-red"
    labels = {
      CustodianRule    = "ecc-k8s-078-cpu_limits_are_set"
      ComplianceStatus = "Red"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-078-red"
    }
  }
}
