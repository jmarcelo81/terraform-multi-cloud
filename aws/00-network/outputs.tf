output "aws_region" {
  value = var.aws_region
}

output "vpc_id" {
  value = aws_vpc.lab_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

output "ec2_instance_id" {
  value = aws_instance.lab_ec2.id
}

output "ec2_public_ip" {
  value = aws_instance.lab_ec2.public_ip
}

output "ssh_command" {
  value = "ssh -i ${path.module}/lab-key-ohio.pem ec2-user@${aws_instance.lab_ec2.public_ip}"
}
