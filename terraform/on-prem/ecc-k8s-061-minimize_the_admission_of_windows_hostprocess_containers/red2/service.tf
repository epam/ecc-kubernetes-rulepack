resource "kubernetes_service_v1" "this" {
  metadata {
    name = "service-061-red2"
    labels = {
      CustodianRule    = "ecc-k8s-061-minimize_the_admission_of_windows_hostprocess_cont"
      ComplianceStatus = "Red2"
    }
  }
  spec {
    selector = {
      CustodianRule    = "ecc-k8s-061-minimize_the_admission_of_windows_hostprocess_cont"
      ComplianceStatus = "Red2"
    }
    session_affinity = "None"
    type             = "LoadBalancer"
    port {
      port        = 82
      target_port = 82
      protocol    = "TCP"
    }
  }

  wait_for_load_balancer = false
  depends_on             = [kubernetes_manifest.this]
}