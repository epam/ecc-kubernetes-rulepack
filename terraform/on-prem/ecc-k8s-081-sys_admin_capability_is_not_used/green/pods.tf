resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-081-green"
    labels = {
      CustodianRule    = "ecc-k8s-081-sys_admin_capability_is_not_used"
      ComplianceStatus = "Green"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-081-green"

      port {
        container_port = 80
      }
    }
  }
}
