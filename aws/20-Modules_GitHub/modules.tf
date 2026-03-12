provider "aws" {
    region = "us-east-2"
}

module "ec2_zara" {
    source = "github.com/zealvora/sample-kplabs-terraform-ec2-module"
}