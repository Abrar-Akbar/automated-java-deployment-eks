variable "vpc_id" {
  description = "ID of the VPC to associate with the Internet Gateway"
  type        = string
}

variable "internet_gateway_name" {
  description = "Name for the Internet Gateway"
  type        = string
}
