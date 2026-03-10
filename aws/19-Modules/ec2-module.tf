

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.3.0"
  subnet_id = "subnet-011afd4f25e607d6d"
}