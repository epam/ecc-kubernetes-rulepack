resource "kubernetes_service_v1" "this" {
  metadata {
    name = "service-061-green"
    labels = {
      CustodianRule    = "ecc-k8s-061-minimize_the_admission_of_windows_hostprocess_cont"
      ComplianceStatus = "Green"
    }
  }
  spec {
    selector = {
      CustodianRule    = "ecc-k8s-061-minimize_the_admission_of_windows_hostprocess_cont"
      ComplianceStatus = "Green"
    }
    session_affinity = "None"
    type             = "LoadBalancer"
    port {
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }
  }

  wait_for_load_balancer = false
  depends_on             = [kubernetes_manifest.this]
}