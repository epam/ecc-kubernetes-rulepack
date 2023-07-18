resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-063-red2"
    labels = {
      CustodianRule    = "ecc-k8s-063-minimize_containers_with_allowprivilegeescalation"
      ComplianceStatus = "Red"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-063-red2"

      port {
        container_port = 80
      }

      security_context {
        allow_privilege_escalation = false
      }
    }
    init_container {
      image   = "busybox"
      name    = "init-container-063-red2"
      command = ["sleep", "5"]

      security_context {
        allow_privilege_escalation = true
      }
    }
  }
}