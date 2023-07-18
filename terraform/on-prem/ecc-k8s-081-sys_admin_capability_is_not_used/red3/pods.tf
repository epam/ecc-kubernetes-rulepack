resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-081-red3"
    labels = {
      CustodianRule    = "ecc-k8s-081-sys_admin_capability_is_not_used"
      ComplianceStatus = "Red"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-081-red3"

      port {
        container_port = 80
      }
    }

    init_container {
      image   = "busybox"
      name    = "init-container-081-red3"
      command = ["sleep", "5"]

      security_context {
        capabilities {
          add = ["SYS_ADMIN"]
        }
      }
    }
  }
}
