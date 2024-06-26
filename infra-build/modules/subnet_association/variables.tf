variable "public_subnet_id" {
  description = "ID of the public subnet"
  type        = string
}

variable "route_table_id" {
  description = "ID of the route table to associate with the subnet"
  type        = string
}
