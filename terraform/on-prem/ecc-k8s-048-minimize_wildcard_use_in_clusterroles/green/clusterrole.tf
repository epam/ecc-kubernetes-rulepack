resource "kubernetes_cluster_role_v1" "this1" {
  metadata {
    name = "role-048-green1"
    labels = {
      CustodianRule    = "ecc-k8s-048-minimize_wildcard_use_in_clusterroles"
      ComplianceStatus = "Green"
    }
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "watch", "list"]
  }
}

resource "kubernetes_cluster_role_v1" "this2" {
  metadata {
    name = "role-048-green2"
    labels = {
      CustodianRule    = "ecc-k8s-048-minimize_wildcard_use_in_clusterroles"
      ComplianceStatus = "Green"
    }
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "pods/*"]
    verbs      = ["get", "list"]
  }
  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = ["batch"]
    resources  = ["jobs"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }
}

resource "kubernetes_cluster_role_v1" "this3" {
  metadata {
    name = "role-048-green3"
    labels = {
      CustodianRule    = "ecc-k8s-048-minimize_wildcard_use_in_clusterroles"
      ComplianceStatus = "Green"
    }
  }

  aggregation_rule {
    cluster_role_selectors {
      match_labels = {
        CustodianRule    = "ecc-k8s-048-minimize_wildcard_use_in_clusterroles"
        ComplianceStatus = "Green"
      }
    }
  }
}