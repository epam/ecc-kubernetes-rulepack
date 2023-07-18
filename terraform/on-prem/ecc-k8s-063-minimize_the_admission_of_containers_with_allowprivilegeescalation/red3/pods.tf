resource "kubernetes_pod_v1" "this" {
  metadata {
    name = "pod-063-red3"
    labels = {
      CustodianRule    = "ecc-k8s-063-minimize_containers_with_allowprivilegeescalation"
      ComplianceStatus = "Red"
    }
  }

  spec {
    container {
      image = "nginx"
      name  = "container-063-red3"

      port {
        container_port = 80
      }

      security_context {
        allow_privilege_escalation = false
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
    curl localhost:8001/api/v1/namespaces/default/pods/pod-063-red3/ephemeralcontainers \
      -XPATCH \
      -H 'Content-Type: application/strategic-merge-patch+json' \
      -d '
    {
        "spec":
        {
            "ephemeralContainers":
            [
                {
                    "name": "ephemeral-container-063-red3",
                    "command": ["sleep 5"],
                    "image": "busybox",
                    "targetContainerName": "container-063-red3",
                    "securityContext": {
                        "allowPrivilegeEscalation": true
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