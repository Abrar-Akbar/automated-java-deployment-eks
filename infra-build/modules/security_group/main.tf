resource "aws_security_group" "automated_security_group" {
  vpc_id = var.vpc_id

  # Allow outbound traffic to specific destinations
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks    = ["0.0.0.0/0"]
  }

  # SSH for communication
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_cidr_blocks
  }

  # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.http_cidr_blocks
  }

  # HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.https_cidr_blocks
  }

  # Jenkins Agent communication port
  ingress {
    from_port   = var.jenkins_agent_port
    to_port     = var.jenkins_agent_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SonarQube UI port
  ingress {
    from_port   = var.sonarqube_ui_port
    to_port     = var.sonarqube_ui_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ArgoCD UI port
  ingress {
    from_port   = var.argocd_ui_port
    to_port     = var.argocd_ui_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Kubernetes API server port
  ingress {
    from_port   = var.kubernetes_api_port
    to_port     = var.kubernetes_api_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
