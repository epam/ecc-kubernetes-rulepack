data "external" "my_public_ip" {
  program = ["bash", "${path.module}/get_my_public_ip.sh"]
}

output "my_public_ip" {
  value = "${data.external.my_public_ip.result.ip}/32"
}

output "master_public_IP" {
  value = aws_instance.master.public_ip
}

output "master_private_IP" {
  value = aws_instance.master.private_ip
}

resource "local_sensitive_file" "this" {
  filename        = "k8s_061_key_pair.pem"
  file_permission = "0400"
  content         = tls_private_key.this.private_key_pem

  depends_on = [tls_private_key.this]
}

output "administrator_password" {
  value      = rsadecrypt(aws_instance.worker.password_data, tls_private_key.this.private_key_pem)
  depends_on = [aws_instance.worker]
  sensitive  = true
}