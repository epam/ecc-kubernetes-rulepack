resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-086-red4"
    labels = {
      CustodianRule    = "ecc-k8s-086-apply_security_context_to_your_pods_and_containers"
      ComplianceStatus = "Red"
    }
  }

  spec {
    security_context {
      seccomp_profile {
        type = "RuntimeDefault"
      }
    }
    container {
      image = "nginx"
      name  = "container-086-red4"

      port {
        container_port = 80
      }

      security_context {
        privileged = false
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
    curl localhost:8001/api/v1/namespaces/default/pods/${kubernetes_pod_v1.this.metadata[0].name}/ephemeralcontainers \
      -XPATCH \
      -H 'Content-Type: application/strategic-merge-patch+json' \
      -d '
    {
        "spec":
        {
            "ephemeralContainers":
            [
                {
                    "name": "ephemeral-${kubernetes_pod_v1.this.spec.0.container.0.name}",
                    "command": ["sh"],
                    "image": "busybox",
                    "targetContainerName": "${kubernetes_pod_v1.this.spec.0.container.0.name}"
                }
            ]
        }
    }'
    kill -9 $proxy_pid
    CMD
    interpreter = ["/bin/bash", "-c"]
  }

  lifecycle {
    replace_triggered_by = [
      kubernetes_pod_v1.this
    ]
  }
}
