variable "my-object" {
  type = object({Name = string, userID = number})
}

output "variable_value_2" {
  value = var.my-object
}