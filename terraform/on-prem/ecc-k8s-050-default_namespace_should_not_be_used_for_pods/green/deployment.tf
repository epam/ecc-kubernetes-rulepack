resource "kubernetes_deployment_v1" "this" {
  metadata {
    name = "deployment-050-green"
    labels = {
      CustodianRule    = "ecc-k8s-050-default_namespace_should_not_be_used_for_pods"
      ComplianceStatus = "Green"
      
    }
    namespace        = kubernetes_namespace_v1.this.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        CustodianRule    = "ecc-k8s-050-default_namespace_should_not_be_used_for_pods"
        ComplianceStatus = "Green"
      }
    }

    template {
      metadata {
        labels = {
          CustodianRule    = "ecc-k8s-050-default_namespace_should_not_be_used_for_pods"
          ComplianceStatus = "Green"
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

resource "kubernetes_namespace_v1" "this" {
  metadata {
    labels = {
      CustodianRule    = "ecc-k8s-050-default_namespace_should_not_be_used_for_pods"
      ComplianceStatus = "Green"
    }
    name = "namespace-050-green"
  }
}