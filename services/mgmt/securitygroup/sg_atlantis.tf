resource "aws_security_group" "atlantis_sg" {
  name        = "${terraform.workspace}-${var.project_name}-atlantis-sg"
  description = "${terraform.workspace}-${var.project_name}-atlantis-sg"
  
  vpc_id      = module.vpc.vpc_id

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

  tags = {
    Name = "KYM-NDP-BASTION-SG"
  }
}
