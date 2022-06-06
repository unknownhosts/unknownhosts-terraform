resource "aws_security_group_rule" "kubectl" {
  security_group_id = "sg-08e46d0a7cb276c8e" 
  source_security_group_id = "sg-02b229f1ae0b3d620"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  description       = "for kubectl ec2 server"
}
