resource "kubernetes_secret_v1" "this" {
  metadata {
    name = "secret-074-green"
  }

  data = {
    secret_key = filebase64("secretfile")
  }
}