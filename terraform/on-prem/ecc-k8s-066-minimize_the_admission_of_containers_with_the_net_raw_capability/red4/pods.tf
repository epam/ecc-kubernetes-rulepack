resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-066-red4"
    labels = {
      CustodianRule    = "ecc-k8s-066-minimize_containers_with_the_net_raw_capability"
      ComplianceStatus = "Red"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-066-red4"

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
    curl localhost:8001/api/v1/namespaces/default/pods/pod-066-red4/ephemeralcontainers \
      -XPATCH \
      -H 'Content-Type: application/strategic-merge-patch+json' \
      -d '
    {
        "spec":
        {
            "ephemeralContainers":
            [
                {
                    "name": "ephemeral-container-066-red4",
                    "command": ["sleep 5"],
                    "image": "busybox",
                    "targetContainerName": "container-066-red4",
                    "securityContext": {
                        "capabilities": {
                          "add": [
                            "NET_RAW"
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