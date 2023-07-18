resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-067-red2"
    labels = {
      CustodianRule    = "ecc-k8s-067-minimize_the_admission_of_containers_with_added"
      ComplianceStatus = "Red2"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-067-red2"

      port {
        container_port = 80
      }

      security_context {
        capabilities {
          add = ["ALL"]
        }
      }
    }
  }
}

resource "null_resource" "this" {
  provisioner "local-exec" {
    command     = <<CMD
    kubectl proxy &>/dev/null &
    proxy_pid=`echo "$!"`
    sleep 3
    curl localhost:8001/api/v1/namespaces/default/pods/pod-067-red2/ephemeralcontainers \
      -XPATCH \
      -H 'Content-Type: application/strategic-merge-patch+json' \
      -d '
    {
        "spec":
        {
            "ephemeralContainers":
            [
                {
                    "name": "ephemeral-container-067-red2",
                    "command": ["sleep 5"],
                    "image": "busybox",
                    "targetContainerName": "container-067-red2",
                    "securityContext": {
                        "capabilities": {
                          "add": ["ALL"]
                        }
                    }
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
