provider "aws" {
    region = "us-east-1"
}

data "aws_instance" "website" {}

output "ec2_id" {
    value = data.aws_instance.website.id
}

output "ec2_name" {
  value = data.aws_instance.website.tags["Name"]
}
