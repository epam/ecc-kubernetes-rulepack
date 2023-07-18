resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-063-green"
    labels = {
      CustodianRule    = "ecc-k8s-063-minimize_containers_with_allowprivilegeescalation"
      ComplianceStatus = "Green"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-063-green"

      port {
        container_port = 80
      }
      security_context {
        allow_privilege_escalation = false
      }
    }
  }
}