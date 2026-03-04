provider "aws"{
    region = "us-east-2"
    profile = "lab-sso"
}

resource "aws_eip" "lb" {
    
    domain = "vpc"
}

resource "aws_instance" "lab" {
    ami = "ami-09256c524fab91d36"
    instance_type = "t2.micro"
}
