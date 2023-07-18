data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "this" {
  name   = "k8s_061_security_group"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${data.external.my_public_ip.result.ip}/32"]
    self        = true
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}