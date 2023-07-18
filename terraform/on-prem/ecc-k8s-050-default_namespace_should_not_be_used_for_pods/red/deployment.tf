resource "kubernetes_deployment_v1" "this" {
  metadata {
    name = "deployment-050-red"
    labels = {
      CustodianRule    = "ecc-k8s-050-default_namespace_should_not_be_used_for_pods"
      ComplianceStatus = "Red"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        CustodianRule    = "ecc-k8s-050-default_namespace_should_not_be_used_for_pods"
        ComplianceStatus = "Red"
      }
    }

    template {
      metadata {
        labels = {
          CustodianRule    = "ecc-k8s-050-default_namespace_should_not_be_used_for_pods"
          ComplianceStatus = "Red"
        }
      }

      spec {
        container {
          image = "nginx:1.21.6"
          name  = "container-050-green"
        }
      }
    }
  }
}
