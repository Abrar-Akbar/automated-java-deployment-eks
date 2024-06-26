variable "vpc_id" {
  description = "ID of the VPC to associate with the security group"
  type        = string
}

variable "ssh_cidr_blocks" {
  description = "CIDR blocks for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "http_cidr_blocks" {
  description = "CIDR blocks for HTTP access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "https_cidr_blocks" {
  description = "CIDR blocks for HTTPS access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "jenkins_agent_port" {
  description = "Port for Jenkins Agent communication"
  type        = number
  default     = 50000
}

variable "sonarqube_ui_port" {
  description = "Port for SonarQube UI"
  type        = number
  default     = 9000
}

variable "argocd_ui_port" {
  description = "Port for ArgoCD UI"
  type        = number
  default     = 8080
}

variable "kubernetes_api_port" {
  description = "Port for Kubernetes API server"
  type        = number
  default     = 6443
}
