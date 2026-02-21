variable "aws_region" {
  description = "AWS region for this lab"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  type        = string
}
