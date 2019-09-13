resource "aws_security_group" "ec2" {
  name   = var.name
  vpc_id = var.vpc_id

  ingress {
    description = "SSH access "
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
    self      = true

    cidr_blocks = var.private_cidr_blocks
  }

  ingress {
    description = "NFS"
    from_port   = 2049
    protocol    = "tcp"
    to_port     = 2049
    self        = true

    cidr_blocks = var.storage_cidr_blocks
  }

  ingress {
    description = "NFS"
    from_port   = 2049
    protocol    = "udp"
    to_port     = 2049
    self        = true

    cidr_blocks = var.storage_cidr_blocks
  }

  ingress {
    description = "NFS"
    from_port   = 111
    protocol    = "tcp"
    to_port     = 111
    self        = true

    cidr_blocks = var.storage_cidr_blocks
  }

  ingress {
    description = "NFS"
    from_port   = 111
    protocol    = "udp"
    to_port     = 111
    self        = true

    cidr_blocks = var.storage_cidr_blocks
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name          = var.name
    business-unit = var.tags["business-unit"]
    application   = var.tags["application"]
    is-production = var.tags["is-production"]
    owner         = var.tags["owner"]
  }
}

resource "aws_security_group" "lb" {
  name   = var.name
  vpc_id = var.vpc_id

  ingress {
    description = "NFS"
    from_port   = 2049
    protocol    = "tcp"
    to_port     = 2049
    self        = true

    cidr_blocks = var.private_cidr_blocks
  }

  ingress {
    description = "NFS"
    from_port   = 2049
    protocol    = "udp"
    to_port     = 2049
    self        = true

    cidr_blocks = var.private_cidr_blocks
  }

  ingress {
    description = "NFS"
    from_port   = 111
    protocol    = "tcp"
    to_port     = 111
    self        = true

    cidr_blocks = var.private_cidr_blocks
  }

  ingress {
    description = "NFS"
    from_port   = 111
    protocol    = "udp"
    to_port     = 111
    self        = true

    cidr_blocks = var.private_cidr_blocks
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name          = var.name
    business-unit = var.tags["business-unit"]
    application   = var.tags["application"]
    is-production = var.tags["is-production"]
    owner         = var.tags["owner"]
  }
}
