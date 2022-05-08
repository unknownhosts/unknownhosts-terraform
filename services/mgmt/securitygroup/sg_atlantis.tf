resource "aws_security_group" "atlantis_sg" {
  name        = "${terraform.workspace}-${var.project_name}-atlantis-sg"
  description = "${terraform.workspace}-${var.project_name}-atlantis-sg"
  
  vpc_id      = data.terraform_remote_state.vpc.outputs.lincoln_vpc_id

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

  tags = merge(local.common_tags, 
        {
          Name = "${terraform.workspace}-${var.project_name}-atlantis-sg"
          createdBy = "jordan.kim"
        })
}
