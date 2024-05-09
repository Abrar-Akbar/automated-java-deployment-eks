variable "vpc_id" {
  description = "ID of the VPC where the route table will be created"
  type        = string
}

variable "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  type        = string
}

variable "public_route_table_name" {
  description = "Name for the public route table"
  type        = string
}
