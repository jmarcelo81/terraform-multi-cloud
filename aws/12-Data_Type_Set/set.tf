provider "aws" {
  region  = "us-east-2"
  profile = "lab-sso"
}

/* variable "my-list" {
    type = list
    default = ["Alice", "Bob", "Marcelo", "Isabela", "Bob"]
}

output "list-values" {
    value = var.my-list
}
*/

variable "my-set" {
    type = set(string)
    default = ["Alice", "Bob", "Marcelo", "Isabela", "Bob"]
}

output "set-values" {
    value = var.my-set
}