resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-074-red2"
    labels = {
      CustodianRule    = "ecc-k8s-074-prefer_using_secrets_as_files"
      ComplianceStatus = "Red"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-074-red2"

      port {
        container_port = 80
      }

      env_from {
        secret_ref {
          name = kubernetes_secret_v1.this.metadata.0.name
        }
      }

    }
  }
}
