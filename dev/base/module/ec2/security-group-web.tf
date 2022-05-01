resource "aws_security_group" "web" {
    name   = "${module.global_variables.this_account_name}-web-sg"
    vpc_id = "${module.global_variables.this_lincoln_vpc_info.outputs.this_vpc_id}"
    tags = {
        Name = "${module.global_variables.this_account_name}-web-sg"
    }
}

resource "aws_security_group_rule" "web-egress" {
  security_group_id = aws_security_group.web.id
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "web-ssh-all" {
  security_group_id = aws_security_group.web.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  description       = "for enginner"
  cidr_blocks       = [ "0.0.0.0/0" ]  
}