variable "aws_region" {
  description = "AWS region for this lab"
  type        = string
}

variable "user_names" {
  type = list
  default = ["Alice", "James", "Marcelo"]
}