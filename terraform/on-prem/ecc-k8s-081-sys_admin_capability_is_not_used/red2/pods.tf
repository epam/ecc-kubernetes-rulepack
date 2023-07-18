resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-081-red2"
    labels = {
      CustodianRule    = "ecc-k8s-081-sys_admin_capability_is_not_used"
      ComplianceStatus = "Red"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-081-red2"

      port {
        container_port = 80
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
                    "targetContainerName": "${kubernetes_pod_v1.this.spec.0.container.0.name}",
                    "securityContext": {
                        "capabilities": {
                          "add": [
                            "SYS_ADMIN"
                          ]
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
