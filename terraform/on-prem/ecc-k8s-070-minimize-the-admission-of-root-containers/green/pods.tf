resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-070-green"
    labels = {
      CustodianRule    = "ecc-k8s-070-minimize-the-admission-of-root-containers"
      ComplianceStatus = "Green"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-070-green"

      port {
        container_port = 80
      }
    }
  }
}