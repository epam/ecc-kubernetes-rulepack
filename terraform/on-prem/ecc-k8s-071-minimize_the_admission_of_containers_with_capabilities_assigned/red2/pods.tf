resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-071-red2"
    labels = {
      CustodianRule    = "ecc-k8s-071-minimize_containers_with_capabilities_assigned"
      ComplianceStatus = "Green"
    }
  }

  spec {
    container {
      image             = var.image
      name              = "container-071-red2"
      image_pull_policy = "Never"
      security_context {
        capabilities {
          drop = ["ALL"]
        }
      }
    }

    init_container {
      image   = "busybox"
      name    = "init-container-071-red2"
      command = ["sleep", "5"]
    }
  }
  depends_on = [null_resource.this]
}


resource "null_resource" "this" {
  triggers = {
    image = var.image
  }

  provisioner "local-exec" {
    command     = <<CMD
    eval $(minikube docker-env)
    docker build . -t ${var.image}
    CMD
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = <<CMD
    eval $(minikube docker-env)
    docker rmi ${self.triggers.image}
    CMD
    interpreter = ["/bin/bash", "-c"]

  }
}

