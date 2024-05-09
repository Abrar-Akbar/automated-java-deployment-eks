# Create Internet Gateway
resource "aws_internet_gateway" "automated_IGW" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.internet_gateway_name
  }
}

output "internet_gateway_id" {
  value = aws_internet_gateway.automated_IGW.id
}
