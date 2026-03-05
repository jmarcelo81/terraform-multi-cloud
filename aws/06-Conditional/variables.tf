variable "aws_region" {
  description = "AWS region for this lab"
  type        = string
}

variable environment {
    default = []
}

variable "user_names" {
  type = list
  default = []
}


