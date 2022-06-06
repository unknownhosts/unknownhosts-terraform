locals {

  // Remote State
  vpc_id             = data.terraform_remote_state.main["vpc"].outputs.vpc_id
  vpc_cidr           = data.terraform_remote_state.main["vpc"].outputs.vpc_cidr
  private_subnet_ids = data.terraform_remote_state.main["vpc"].outputs.private_subnet_ids
  public_subnet_ids  = data.terraform_remote_state.main["vpc"].outputs.public_subnet_ids

  // Variables
  ami_id        = data.aws_ami.amazon2.id
  instance_type = var.instance_type
  key_name      = var.key_name
}
