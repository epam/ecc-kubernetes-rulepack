resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-074-green"
    labels = {
      CustodianRule    = "ecc-k8s-074-prefer_using_secrets_as_files"
      ComplianceStatus = "Green"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-074-green"

      port {
        container_port = 80
      }

      volume_mount {
        name       = "volume-074-green"
        mount_path = "/secret_folder"
      }

    }

    volume {
      name = "volume-074-green"
      secret {
        secret_name = kubernetes_secret_v1.this.metadata[0].name
      }
    }
  }
}
