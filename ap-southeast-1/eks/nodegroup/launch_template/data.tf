data "aws_availability_zones" "this" {
  state = "available"
}

data "template_file" "userdata" {
  template = file("${path.module}/userdata.tpl")
  vars = {
    CLUSTER_NAME = local.cluster_name
  }
}

// NodeGroup Assumed Role
data "aws_iam_policy_document" "nodegroup_assumed_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
