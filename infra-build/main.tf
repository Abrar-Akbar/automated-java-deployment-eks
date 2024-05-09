# Define your provider
provider "aws" {
  region = var.region
}

# Include VPC module
module "vpc" {
  source = "./modules/vpc"

  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  vpc_name             = var.vpc_name
  private_subnet_cidr  = var.private_subnet_cidr
  public_subnet_cidr   = var.public_subnet_cidr
  availability_zone    = var.availability_zone
}

# Include Instances module
module "instances" {
  source = "./modules/instances"

  ami_id                   = var.ami_id
  key_pair_name            = var.key_pair_name
  instance_type_master     = var.instance_type_master
  instance_type_agent      = var.instance_type_agent
  instance_type_bootstrap  = var.instance_type_bootstrap
  root_volume_size         = var.root_volume_size
  root_volume_type         = var.root_volume_type
  subnet_id                = module.vpc.public_subnet_id
  security_groups          = [module.security_group.security_group_id] # assuming you have a security group module
  master_instance_name     = var.master_instance_name
  agent_instance_name      = var.agent_instance_name
  bootstrap_instance_name  = var.bootstrap_instance_name
}

# Include Internet Gateway module
module "internet_gateway" {
  source = "./modules/internet_gateway"

  vpc_id                 = module.vpc.vpc_id
  internet_gateway_name  = var.internet_gateway_name
}

# Include Route Table module
module "route_table" {
  source = "./modules/route_table"

  vpc_id                   = module.vpc.vpc_id
  internet_gateway_id      = module.internet_gateway.internet_gateway_id
  public_route_table_name  = var.public_route_table_name
}

# Include Subnet Association module
module "subnet_association" {
  source = "./modules/subnet_association"

  public_subnet_id = module.vpc.public_subnet_id
  route_table_id   = module.route_table.route_table_id
}
