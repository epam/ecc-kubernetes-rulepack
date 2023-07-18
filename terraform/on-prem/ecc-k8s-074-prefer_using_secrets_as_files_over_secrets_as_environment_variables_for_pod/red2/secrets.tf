resource "kubernetes_secret_v1" "this" {
  metadata {
    name = "secret-074-red2"
  }

  data = {
    "${var.secret_key}" = "${var.secret_value}"
  }
}