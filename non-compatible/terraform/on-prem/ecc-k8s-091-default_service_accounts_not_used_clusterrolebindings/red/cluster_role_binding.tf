resource "kubernetes_namespace_v1" "this" {
  metadata {
    labels = {
      CustodianRule    = "ecc-k8s-091-default_service_accounts_not_used_clusterrolebindin"
      ComplianceStatus = "Red"
    }
    name = "namespace-091-red"
  }
}

resource "kubernetes_cluster_role_v1" "this" {
  metadata {
    name = "cluster-role-091-red"
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding_v1" "this" {
  metadata {
    name = "cluster-role-binding-091-red"
    labels = {
      CustodianRule    = "ecc-k8s-091-default_service_accounts_not_used_clusterrolebindin"
      ComplianceStatus = "Red"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.this.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }
}
