resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-060-red"
    labels = {
      CustodianRule    = "ecc-k8s-060-minimize_the_admission_of_hostpath_volumes"
      ComplianceStatus = "Red"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-060-red"

      port {
        container_port = 80
      }
      volume_mount{
        mount_path = "/mnt"
        name = "volume-060-red01"
      }
      volume_mount{
        mount_path = "/home"
        name = "volume-060-red02"
      }
    }
    volume {
      name = "volume-060-red01"
      host_path {
        path = "/"
      }
    }
    volume {
      name = "volume-060-red02"
      host_path {
        path = "/home"
      }
    }
  }
}