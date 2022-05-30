resource "aws_security_group" "atlantis_sg" {
  name        = "${var.project_name}-${var.resource_name}-mgmt-atlantis-sg"
  description = "${var.project_name}-${var.resource_name}-mgmt-atlantis-sg"
  
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc[0].vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = merge(
        {
          Name = "${var.project_name}-${var.resource_name}-mgmt-atlantis-sg"
        },
        var.tags
        )
}
