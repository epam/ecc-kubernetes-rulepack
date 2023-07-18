resource "kubernetes_deployment_v1" "this" {
  metadata {
    name = "deployment-052-green"
    labels = {
      CustodianRule    = "ecc-k8s052-default_namespace_should_not_be_used_for_deployment"
      ComplianceStatus = "Green"

    }
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        CustodianRule    = "ecc-k8s052-default_namespace_should_not_be_used_for_deployment"
        ComplianceStatus = "Green"
      }
    }

    template {
      metadata {
        labels = {
          CustodianRule    = "ecc-k8s052-default_namespace_should_not_be_used_for_deployment"
          ComplianceStatus = "Green"
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

resource "kubernetes_namespace_v1" "this" {
  metadata {
    labels = {
      CustodianRule    = "ecc-k8s052-default_namespace_should_not_be_used_for_deployment"
      ComplianceStatus = "Green"
    }
    name = "namespace-052-green"
  }
}