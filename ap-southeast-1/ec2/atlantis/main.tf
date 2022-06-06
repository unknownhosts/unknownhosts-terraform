module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "${local.name_prefix}-atlantis"

  ami           = local.ami_id
  key_name      = local.key_name
  instance_type = local.instance_type

  availability_zone      = data.aws_availability_zones.this.names[0]
  subnet_id              = local.public_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.atlantis.id]
  iam_instance_profile   = aws_iam_instance_profile.atlantis.name

  associate_public_ip_address = true

  root_block_device = [
    {
      volume_type = "gp3"
      volume_size = 10
    },
  ]
  # zz
  user_data_base64 = base64encode(data.template_file.userdata.rendered)

}



resource "aws_security_group" "atlantis" {

  name   = "${local.name_prefix}-atlantis-sg"
  vpc_id = local.vpc_id

  tags = merge(
    local.tags,
    {
      Name = "${local.name_prefix}-atlantis-sg"
    },
  )

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["54.180.72.55/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role" "atlantis" {
  name               = "${local.name_prefix}-atlantis-role"
  assume_role_policy = data.aws_iam_policy_document.assumed_role_policy.json
  tags = merge(
    {
      Name = "${local.name_prefix}-atlantis-role"
    },
    local.tags
  )
}

resource "aws_iam_instance_profile" "atlantis" {
  name = "${local.name_prefix}-atlantis-role"
  role = aws_iam_role.atlantis.name
}
