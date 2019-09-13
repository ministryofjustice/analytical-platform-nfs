resource "aws_lb" "nfs_lb" {
  name               = "${var.name}-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.lb.id}"]
  subnets            = var.storage_subnet_ids

  enable_deletion_protection = false

  access_logs {
    bucket  = "${aws_s3_bucket.lb_logs.id}"
    prefix  = "${terraform.workspace}-nfs-lb"
    enabled = true
  }

  tags = {
    Name          = var.name
    business-unit = var.tags["business-unit"]
    application   = var.tags["application"]
    is-production = var.tags["is-production"]
    owner         = var.tags["owner"]
  }
}

resource "aws_s3_bucket" "lb_logs" {
  bucket = "${var.name}-lb-logs-bucket"
  acl    = "private"

  lifecycle_rule {
    id      = "log"
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 360
    }
  }
}

resource "aws_s3_bucket_public_access_block" "lb_logs_block_public_acl" {
  bucket = "${aws_s3_bucket.lb_logs.id}"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
