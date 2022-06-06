resource "aws_security_group" "launch_template" {

  name   = "${local.name_prefix}-nodegroup-sg"
  vpc_id = local.vpc_id

  tags = merge(
    local.tags,
    {
      Name = "${local.name_prefix}-nodegroup-sg"
    },
  )

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [local.vpc_cidr]
    description = "Allow ALL Traffic from ${local.env} VPC CIDR"
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