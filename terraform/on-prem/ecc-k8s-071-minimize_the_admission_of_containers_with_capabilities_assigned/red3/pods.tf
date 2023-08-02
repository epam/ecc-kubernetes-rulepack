resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-071-red3"
    labels = {
      CustodianRule    = "ecc-k8s-071-minimize_containers_with_capabilities_assigned"
      ComplianceStatus = "Green"
    }
  }

  spec {
    container {
      image             = var.image
      name              = "container-071-red3"
      image_pull_policy = "Never"
      security_context {
        capabilities {
          drop = ["ALL"]
        }
      }
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
    # eval $(minikube docker-env)
    docker build . -t ${var.image}
    kind load docker-image ${var.image} --name `kind get clusters`
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

resource "null_resource" "this2" {
  provisioner "local-exec" {
    command     = <<CMD
    kubectl proxy &>/dev/null &
    proxy_pid=`echo "$!"`
    sleep 3
    curl localhost:8001/api/v1/namespaces/default/pods/pod-071-red3/ephemeralcontainers \
      -XPATCH \
      -H 'Content-Type: application/strategic-merge-patch+json' \
      -d '
    {
        "spec":
        {
            "ephemeralContainers":
            [
                {
                    "name": "ephemeral-container-070-red4",
                    "command": ["sh"],
                    "image": "busybox",
                    "targetContainerName": "container-071-red3"
                }
            ]
        }
    }'
    kill -9 $proxy_pid
    CMD
    interpreter = ["/bin/bash", "-c"]
  }

  depends_on = [kubernetes_pod_v1.this]
}

