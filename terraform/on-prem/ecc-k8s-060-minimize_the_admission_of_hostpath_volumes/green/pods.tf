resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-060-green"
    labels = {
      CustodianRule    = "ecc-k8s-060-minimize_the_admission_of_hostpath_volumes"
      ComplianceStatus = "Green"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-060-green"

      port {
        container_port = 80
      }
      volume_mount{
        mount_path = "/home"
        name = "volume-060-red02"
      }
    }
    volume {
      name = "volume-060-green01"
      config_map {
        name = kubernetes_config_map_v1.this.metadata[0].name
      }
    }

  }
}

resource "kubernetes_config_map_v1" "this" {
  metadata {
    name = "configmap-060-green"
    labels = {
      CustodianRule    = "ecc-k8s-060-minimize_the_admission_of_hostpath_volumes"
      ComplianceStatus = "Green"
    }
  }
  data = {
    green-data-key = "green"
  }
}