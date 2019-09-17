data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "nfs_server_policy" {
  statement {
    sid = "ec2_permissions"
    actions = [
      "ec2:CreateVolume",
      "ec2:DescribeVolumes",
      "ec2:AttachVolume",
      "ec2:DetachVolume",
      "ec2:DeleteVolume",
    ]
    resources = [
      "*"
    ]
  }

  statement {
    sid = "route53_permissions"
    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:ListResourceRecordSets"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_role" "nfs_server" {
  name                  = var.name
  assume_role_policy    = data.aws_iam_policy_document.assume_role_policy.json
  force_detach_policies = true
}

resource "aws_iam_role_policy" "ec2_policy_attachment" {
  name_prefix = "nfs-ec2-policy"
  policy      = data.aws_iam_policy_document.nfs_server_policy.json
  role        = aws_iam_role.nfs_server.name
}

resource "aws_iam_instance_profile" "nfs_server" {
  name = var.name
  role = aws_iam_role.nfs_server.name
}
