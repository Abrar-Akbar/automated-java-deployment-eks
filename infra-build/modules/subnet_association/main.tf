# Associate public subnet with public route table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = var.public_subnet_id
  route_table_id = var.route_table_id
}
