resource "aws_security_group" "bastion" {
    name   = "${module.global_variables.this_account_name}-bastion-sg"
    vpc_id = "${module.global_variables.this_lincoln_vpc_info.outputs.this_vpc_id}"
    tags = {
        Name = "${module.global_variables.this_account_name}-bastion-sg"
    }
}

resource "aws_security_group_rule" "bastion-egress" {
  security_group_id = aws_security_group.bastion.id
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "bastion-ssh-all" {
  security_group_id = aws_security_group.bastion.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  description       = "for enginner"
  cidr_blocks       = [ "0.0.0.0/0" ]  
}