provider "aws" {
  region = "us-east-2"
  profile = "lab-sso"
}

data "aws_ami" "latest_os" {
  most_recent      = true
  owners           = ["amazon"]
  
  filter {
    name = "name"
    values = ["ubuntu/images-testing/hvm-ssd/ubuntu-jammy-daily-amd64-server-*"]
  }
}

resource "aws_instance" "web" {
    ami           = data.aws_ami.latest_os.image_id
    instance_type = "t2.micro"
}