provider "aws" {
  region = var.aws_region
  profile = "lab-sso"
}


resource "aws_instance" "ec2-test" {
    ami = var.environment == "dev" ? "ami-09256c524fab91d36" : "ami-05f30bc03d7e942e5"

    instance_type = var.environment == "dev" ? "t2.micro" : "t4g.micro"
    
    tags = {
      Name = "Celo"
    }
}
