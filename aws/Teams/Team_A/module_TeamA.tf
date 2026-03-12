

module "ec2" {
  source        = "../../Modules/EC2"
}

resource "aws_eip" "my_eip" {
  domain = "vpc"
  instance = module.ec2.instance_id 
}