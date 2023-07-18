resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-059-red"
    labels = {
      CustodianRule    = "ecc-k8s-059-service_account_tokens_are_only_mounted"
      ComplianceStatus = "Red"
    }
  }
  spec {
    automount_service_account_token = true
    container {
      image  = "nginx:1.21.6"
      name   = "container-059-red"
      port {
        container_port = 80
      }
    }
  }
}
