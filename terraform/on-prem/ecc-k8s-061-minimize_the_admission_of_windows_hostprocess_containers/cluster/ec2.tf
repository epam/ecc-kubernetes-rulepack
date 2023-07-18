# Based on this documentation: https://github.com/kubernetes-sigs/sig-windows-tools/blob/ee59f5de23a54d53a0e21531aab5beedf2bd0058/guides/guide-for-adding-windows-node.md

resource "aws_instance" "master" {
  ami                         = "ami-007855ac798b5175e"
  instance_type               = "t2.medium"
  key_name                    = aws_key_pair.this.key_name
  iam_instance_profile        = aws_iam_instance_profile.this.name
  availability_zone           = local.subnet_name
  associate_public_ip_address = true
  security_groups             = [aws_security_group.this.name]
  user_data                   = templatefile("bootstrap_kmaster.sh", { bucket = aws_s3_bucket.this.id })

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 12
    delete_on_termination = true
  }
  private_dns_name_options {
    enable_resource_name_dns_aaaa_record = false
    enable_resource_name_dns_a_record    = false
    hostname_type                        = "ip-name"
  }
  tags = {
    Name = "k8s-master-061"
  }
  depends_on = [aws_security_group.this]
}

resource "aws_instance" "worker" {
  ami                         = "ami-0b7dd7b9e977b2b85"
  instance_type               = "t2.medium"
  key_name                    = aws_key_pair.this.key_name
  availability_zone           = local.subnet_name
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.this.name
  security_groups             = [aws_security_group.this.name]
  get_password_data           = true
  user_data                   = templatefile("bootstrap_kworker.ps1", { private_key = tls_private_key.this.private_key_pem, master_ip = aws_instance.master.private_ip, bucket = aws_s3_bucket.this.id })

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 35
    delete_on_termination = true
  }

  private_dns_name_options {
    enable_resource_name_dns_aaaa_record = false
    enable_resource_name_dns_a_record    = false
    hostname_type                        = "ip-name"
  }
  tags = {
    Name = "k8s-worker-061"
  }
  depends_on = [aws_instance.master, aws_security_group.this]
}


resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  key_name   = "k8s_061_key_pair"
  public_key = tls_private_key.this.public_key_openssh
}
