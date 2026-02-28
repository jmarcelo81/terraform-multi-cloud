provider "aws" {
  region = var.aws_region
  profile = "lab-sso"
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

##############################
# Latest Amazon Linux 2023 AMI
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Security Group: SSH from your IP only
resource "aws_security_group" "ssh_sg" {
  name        = "lab-ssh-sg"
  description = "Allow SSH from my IP"
  vpc_id      = aws_vpc.lab_vpc.id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lab-ssh-sg-ohio"
    Env  = "lab"
  }
}

# Generate a local SSH keypair (for lab use)
resource "tls_private_key" "lab_key" {
  algorithm = "ED25519"
}

# Register public key in AWS
resource "aws_key_pair" "lab_keypair" {
  key_name   = "lab-key-ohio"
  public_key = tls_private_key.lab_key.public_key_openssh

  tags = {
    Name = "lab-key-ohio"
    Env  = "lab"
  }
}

# Save private key locally (do not commit)
resource "local_file" "lab_private_key" {
  filename        = "${path.module}/lab-key-ohio.pem"
  content         = tls_private_key.lab_key.private_key_openssh
  file_permission = "0600"
}

# EC2 instance in the public subnet
resource "aws_instance" "lab_ec2" {
  ami                         = data.aws_ami.al2023.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.ssh_sg.id]
  key_name                    = aws_key_pair.lab_keypair.key_name
  associate_public_ip_address = true

  tags = {
    Name = "lab-ec2-ohio"
    Env  = "lab"
  }
}
