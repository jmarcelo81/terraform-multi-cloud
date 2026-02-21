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
