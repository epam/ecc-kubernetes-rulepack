resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-074-red"
    labels = {
      CustodianRule    = "ecc-k8s-074-prefer_using_secrets_as_files"
      ComplianceStatus = "Red"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-074-red"

      port {
        container_port = 80
      }

      env {
        name = var.secret_key
        value_from {
          secret_key_ref {
            name = kubernetes_secret_v1.this.metadata.0.name
            key  = var.secret_key
          }
        }
      }

    }
  }
}

