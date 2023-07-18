resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-072-red"
    labels = {
      CustodianRule    = "ecc-k8s-072-readonly_filesystem_is_configured"
      ComplianceStatus = "Red"
    }
  }
  spec {
    container {
      image  = "nginx:1.21.6"
      name   = "container-072-red"
      security_context {
        read_only_root_filesystem = false
      }
      port {
        container_port = 80
      }
    }
  }
}
