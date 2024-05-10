provider "aws" {
  region = var.aws_region
}

# Create VPC
resource "aws_vpc" "automated_vpc" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "automated VPC"
  }
}

# Create private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.automated_vpc.id
  cidr_block              = "172.16.25.0/24"
  availability_zone       = "us-east-1b" # Change as needed
  map_public_ip_on_launch = false
  tags = {
    Name = "automated Private Subnet"
  }
}

# Create public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.automated_vpc.id
  cidr_block              = "172.16.26.0/24"
  availability_zone       = "us-east-1b" # Change as needed
  map_public_ip_on_launch = true
  tags = {
    Name = "automated Public Subnet"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "automated_IGW" {
  vpc_id = aws_vpc.automated_vpc.id
  tags = {
    Name = "automated Gateway"
  }
}

# Create Route Table for public subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.automated_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.automated_IGW.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

# Associate public subnet with public route table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Create Route Table for private subnet
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.automated_vpc.id
  tags = {
    Name = "Private Route Table"
  }
}

# Associate private subnet with private route table
resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

# Create security group
resource "aws_security_group" "automated_security_group" {
  vpc_id = aws_vpc.automated_vpc.id

  # Allow outbound traffic to specific destinations
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH for communication
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Jenkins Agent communication port
  ingress {
    from_port   = 50000
    to_port     = 50000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SonarQube UI port
  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ArgoCD UI port
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Kubernetes API server port
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Nginx proxy manager server port
  ingress {
    from_port   = 81
    to_port     = 81
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# Create EC2 instances
resource "aws_instance" "automated_master" {
  ami                         = var.ami_id
  instance_type               = var.instance_type_master
  subnet_id                   = aws_subnet.public_subnet.id
  key_name                    = var.key_pair_name
  associate_public_ip_address = true
  private_ip                  = "172.16.26.101"
  vpc_security_group_ids      = [aws_security_group.automated_security_group.id]
  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = true
  }

  tags = {
    Name = "automated-master"
  }
}

resource "aws_instance" "automated_agent" {
  ami                         = var.ami_id
  instance_type               = var.instance_type_agent
  subnet_id                   = aws_subnet.public_subnet.id
  key_name                    = var.key_pair_name
  associate_public_ip_address = true
  private_ip                  = "172.16.26.111"
  vpc_security_group_ids      = [aws_security_group.automated_security_group.id]
  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = true
  }

  tags = {
    Name = "automated-agent"
  }
}

resource "aws_instance" "automated_bootstrap" {
  ami                         = var.ami_id
  instance_type               = var.instance_type_bootstrap
  subnet_id                   = aws_subnet.public_subnet.id
  key_name                    = var.key_pair_name
  associate_public_ip_address = true
  private_ip                  = "172.16.26.112"
  vpc_security_group_ids      = [aws_security_group.automated_security_group.id]
  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = true
  }

  tags = {
    Name = "automated-bootstrap"
  }
}
