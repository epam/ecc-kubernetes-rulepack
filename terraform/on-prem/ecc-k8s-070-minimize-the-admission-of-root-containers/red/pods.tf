resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-070-red"
    labels = {
      CustodianRule    = "ecc-k8s-070-minimize-the-admission-of-root-containers"
      ComplianceStatus = "Red"
    }
  }

  spec {
    security_context {
      run_as_non_root = false
      run_as_user     = "0"
    }

    container {
      image = "nginx"
      name  = "container-070-red"

      port {
        container_port = 80
      }
    }
  }
}