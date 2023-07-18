resource "kubernetes_deployment_v1" "this" {
  metadata {
    name = "deployment-052-red"
    labels = {
      CustodianRule    = "ecc-k8s052-default_namespace_should_not_be_used_for_deployment"
      ComplianceStatus = "Red"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        CustodianRule    = "ecc-k8s052-default_namespace_should_not_be_used_for_deployment"
        ComplianceStatus = "Red"
      }
    }

    template {
      metadata {
        labels = {
          CustodianRule    = "ecc-k8s052-default_namespace_should_not_be_used_for_deployment"
          ComplianceStatus = "Red"
        }
      }

      spec {
        container {
          image = "nginx:1.21.6"
          name  = "container-052-green"
        }
      }
    }
  }
}
