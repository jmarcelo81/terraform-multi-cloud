provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "lab_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "lab-vpc-ohio"
    Env  = "lab"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.lab_vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "lab-public-subnet-ohio"
    Env  = "lab"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.lab_vpc.id

  tags = {
    Name = "lab-igw-ohio"
    Env  = "lab"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.lab_vpc.id

  tags = {
    Name = "lab-public-rt-ohio"
    Env  = "lab"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}
