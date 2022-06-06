data "aws_availability_zones" "this" {
  state = "available"
}

data "aws_ami" "amazon2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}

data "template_file" "userdata" {
  template = file("${path.module}/userdata.tpl")
}

data "aws_iam_policy_document" "assumed_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
