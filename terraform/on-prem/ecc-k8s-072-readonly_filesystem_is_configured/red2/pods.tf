resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-072-red2"
    labels = {
      CustodianRule    = "ecc-k8s-072-readonly_filesystem_is_configured"
      ComplianceStatus = "Red2"
    }
  }
  spec {
    container {
      image  = "nginx:1.21.6"
      name   = "container-072-red2"
      security_context {
        read_only_root_filesystem = false
      }
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
    curl localhost:8001/api/v1/namespaces/default/pods/pod-072-red2/ephemeralcontainers \
      -XPATCH \
      -H 'Content-Type: application/strategic-merge-patch+json' \
      -d '
    {
        "spec":
        {
            "ephemeralContainers":
            [
                {
                    "name": "ephemeral-container-072-red2",
                    "command": ["sleep 5"],
                    "image": "busybox",
                    "targetContainerName": "container-072-red2",
                    "securityContext": {
                        "readOnlyRootFilesystem": false
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
