resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-070-red2"
    labels = {
      CustodianRule    = "ecc-k8s-070-minimize-the-admission-of-root-containers"
      ComplianceStatus = "Red"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-070-red2"

      port {
        container_port = 80
      }
      security_context {
        run_as_non_root = false
        run_as_user     = "0"
      }
    }
  }
}