resource "kubernetes_config_map" "this" {
  metadata {
    name = "config-map-072-green"
    labels = {
      CustodianRule    = "ecc-k8s-072-readonly_filesystem_is_configured"
      ComplianceStatus = "Green"
    }
  }

  data = {
    "nginx.conf" = <<-EOT
      user  nginx;
      worker_processes  auto;

      error_log  /tmp/nginx/error.log warn;
      pid        /tmp/nginx/nginx.pid;

      events {
        worker_connections  1024;
      }

      http {
        server {
          listen 8080;
          location / {
            add_header Content-Type text/plain;
            return 200 'hello world';
          }
        }
      }
    EOT
  }
}
