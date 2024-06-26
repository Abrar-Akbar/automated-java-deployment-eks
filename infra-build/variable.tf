variable "aws_region" {
  description = "Name of the AWS region"
  type        = string
}
variable "key_pair_name" {
  description = "Name of the key pair"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for your EC2 instances"
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
  description = "The root volume type define"
  default     = "gp2" # General Purpose SSD
  type        = string
}
