resource "aws_security_group" "was" {
    name   = "${module.global_variables.this_account_name}-was-sg"
    vpc_id = "${module.global_variables.this_lincoln_vpc_info.outputs.this_vpc_id}"
    tags = {
        Name = "${module.global_variables.this_account_name}-was-sg"
    }
}

resource "aws_security_group_rule" "was-egress" {
  security_group_id = aws_security_group.was.id
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "was-ssh-all" {
  security_group_id = aws_security_group.was.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  description       = "for enginner"
  cidr_blocks       = [ "0.0.0.0/0" ]  
}