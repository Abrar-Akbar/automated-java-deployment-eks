# Create VPC
resource "aws_vpc" "automated_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    Name = var.vpc_name
  }
}

# Create private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.automated_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.availability_zone
  map_public_ip_on_launch = false
  tags = {
    Name = var.private_subnet_name
  }
}

# Create public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.automated_vpc.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = var.public_subnet_name
  }
}

output "vpc_id" {
  value = aws_vpc.automated_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}
