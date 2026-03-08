provider "aws" {
  region  = "us-east-2"
  profile = "lab-sso"
}

variable "user_names" {
  type    = set(string)
  default = ["Alice", "Bob", "John", "James", "Frank"]
}

resource "aws_iam_user" "this" {
  for_each = var.user_names
  name     = each.value
}

output "set-values" {
  value = var.user_names
}


/* for each with MAP 
variable "my-map" {
    default = {
        key = "value"
        key1 = "value1"
        ke2 = "value2"
    }
}

resource "aws_instance" "web" {
  for_each      = var.my-map
  ami           = each.value
  instance_type = "t3.micro"

  tags = {
    Name = each.key
  }
}
*/

/* Add 5 IAM users with different values - MANUAL, 
resource "aws_iam_user" "devs" {
    name = "Alice"
}

resource "aws_iam_user" "devs" {
    name = "Bob"
}

resource "aws_iam_user" "devs" {
    name = "John"
}

resource "aws_iam_user" "devs" {
    name = "James"
}

resource "aws_iam_user" "devs" {
    name = "Frank"
}
/* Note: Remember that count is multiple sets of same objects without different configurations */

/* for each with SET */