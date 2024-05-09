# Create EC2 instances
resource "aws_instance" "automated_master" {
  ami                         = var.ami_id
  instance_type               = var.instance_type_master
  subnet_id                   = var.subnet_id
  key_name                    = var.key_pair_name
  associate_public_ip_address = true
  vpc_security_group_ids      = var.security_groups
  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = true
  }

  tags = {
    Name = var.master_instance_name
  }
}

resource "aws_instance" "automated_agent" {
  ami                         = var.ami_id
  instance_type               = var.instance_type_agent
  subnet_id                   = var.subnet_id
  key_name                    = var.key_pair_name
  associate_public_ip_address = true
  vpc_security_group_ids      = var.security_groups
  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = true
  }

  tags = {
    Name = var.agent_instance_name
  }
}

resource "aws_instance" "automated_bootstrap" {
  ami                         = var.ami_id
  instance_type               = var.instance_type_bootstrap
  subnet_id                   = var.subnet_id
  key_name                    = var.key_pair_name
  associate_public_ip_address = true
  vpc_security_group_ids      = var.security_groups
  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = true
  }

  tags = {
    Name = var.bootstrap_instance_name
  }
}
