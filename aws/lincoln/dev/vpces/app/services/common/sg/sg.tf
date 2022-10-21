
locals {
  test_name = join("-", compact([
    "test",
    "sg"
    ])
  )
}

resource "aws_security_group" "test" {
  name        = local.test_name
  description = local.test_name

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc[0].vpc_id

  ingress {
    description = "in_443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  tags = merge(
    {
      "Name" = local.test_name
    },
    var.tags
  )
}
