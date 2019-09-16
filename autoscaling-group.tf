resource "aws_autoscaling_group" "nfs_asg" {
  name                      = "${var.name}-asg"
  max_size                  = 1
  min_size                  = 1
  desired_capacity          = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  vpc_zone_identifier       = var.storage_subnet_ids

  launch_template {
    id      = "${aws_launch_template.nfs.id}"
    version = "$Latest"
  }
}


resource "aws_launch_template" "nfs" {
  name = "${var.name}-launch-template"

  disable_api_termination = true

  ebs_optimized = true


  iam_instance_profile {
    name = aws_iam_instance_profile.nfs_server.name
  }

  image_id = var.instance_ami_id

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = var.instance_type

  key_name = var.key_pair

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = false
  }

  vpc_security_group_ids = ["create-using-module-inputs"]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name          = var.name
      business-unit = var.tags["business-unit"]
      application   = var.tags["application"]
      is-production = var.tags["is-production"]
      owner         = var.tags["owner"]
    }
  }

  user_data = "${base64encode(data.template_file.user_data.rendered)}"
}


data "template_file" "user_data" {
  template = <<EOF
      echo 'test'
      ansible-playbook ${var.ansible_provision_file} --extra-vars='ebs_volume_id=${var.ebs_volume_id} \
                                                                   hosted_zone_name=${var.zone_name}'
  EOF
}
