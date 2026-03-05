provider "aws" {
  region = var.aws_region
  profile = "lab-sso"
}

resource "aws_instance" "ec2-test" {
    ami = "ami-09256c524fab91d36"
    instance_type = "t2.micro"
    count = 3

    tags = {
      Name = "Celo-${count.index}"
    }
}

resource "aws_iam_user" "test" {
  name = var.user_names[count.index]
  count = 3
}
