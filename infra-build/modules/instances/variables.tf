variable "ami_id" {
  description = "AMI ID for your EC2 instances"
  type        = string
}

variable "key_pair_name" {
  description = "Name of the key pair"
  type        = string
}

variable "instance_type_master" {
  description = "The instance type for the jenkins-master EC2 instance."
  default     = "t2.micro"
  type        = string
}

variable "instance_type_bootstrap" {
  description = "The instance type for the EKS-bootstrap EC2 instance."
  default     = "t2.micro"
  type        = string
}

variable "instance_type_agent" {
  description = "The instance type for the jenkins-agent EC2 instances."
  default     = "t3.medium"
  type        = string
}

variable "root_volume_size" {
  description = "The size of the root volume for EC2 instances."
  default     = 20
  type        = number
}

variable "root_volume_type" {
  description = "The root volume type"
  default     = "gp2" # General Purpose SSD
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet where instances will be launched"
  type        = string
}

variable "security_groups" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "master_instance_name" {
  description = "Name for the master instance"
  type        = string
}

variable "agent_instance_name" {
  description = "Name for the agent instances"
  type        = string
}

variable "bootstrap_instance_name" {
  description = "Name for the bootstrap instance"
  type        = string
}
