resource "kubernetes_deployment" "this" {
  metadata {
    name = "deployment-072-red1"
    labels = {
      CustodianRule    = "ecc-k8s-072-readonly_filesystem_is_configured"
      ComplianceStatus = "Red1"
    }
  }
  spec {
    replicas = 1

    selector {
      match_labels = {
        CustodianRule    = "ecc-k8s-072-readonly_filesystem_is_configured"
        ComplianceStatus = "Red1"
      }
    }

    template {
      metadata {
        labels = {
          CustodianRule    = "ecc-k8s-072-readonly_filesystem_is_configured"
          ComplianceStatus = "Red1"
        }
      }

      spec {
        init_container {
          image  = "busybox"
          name   = "init-container-072-red1"
          command = ["sleep", "5"]
          security_context {
            read_only_root_filesystem = false
          }
        }
        container {
          name  = "container-072-red1"
          image = "nginx"

          port {
            container_port = 8080
          }

          security_context {
            read_only_root_filesystem = true
          }

          volume_mount {
            name      = "cache"
            mount_path = "/var/cache/nginx"
          }

          volume_mount {
            name      = "tmp"
            mount_path = "/tmp/nginx"
          }

          volume_mount {
            name      = "conf"
            mount_path = "/etc/nginx/nginx.conf"
            sub_path   = "nginx.conf"
          }
        }

        volume {
          name = "cache"

          empty_dir {}
        }

        volume {
          name = "tmp"

          empty_dir {}
        }

        volume {
          name = "conf"

          config_map {
            name = "config-map-072-red1"
          }
        }
      }
    }
  }
}
