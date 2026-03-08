provider "aws" {
  region  = "us-east-2"
  profile = "lab-sso"
}

variable "sg_ports" {
  type    = list(number)
  default = [8200, 8201, 8300, 8800, 9090, 9100, 9500]
}

resource "aws_security_group" "demo_sg" {
  name        = "lab-dynamic-block-sg"
  description = "Create ingress rules with dynamic block"

  dynamic "ingress" {
    for_each = var.sg_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
}