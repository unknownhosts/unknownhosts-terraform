locals {

  // Remote State

  // VPC
  vpc_id             = data.terraform_remote_state.main["vpc"].outputs.vpc_id
  vpc_cidr           = data.terraform_remote_state.main["vpc"].outputs.vpc_cidr
  private_subnet_ids = data.terraform_remote_state.main["vpc"].outputs.private_subnet_ids

  // EKS Cluster
  cluster_name = data.terraform_remote_state.main["eks/cluster"].outputs.cluster_id

  // Variables
  launch_template = {
    image_id      = var.launch_template_image_id
    instance_type = var.launch_template_instance_type
    key_name      = var.launch_template_key_name
    sg_ids        = [aws_security_group.launch_template.id]
  }

  nodegroup = {
    desired_size = var.lodegroup_desired_size
    min_size     = var.lodegroup_min_size
    max_size     = var.lodegroup_max_size
    lt_version   = var.nodegroup_lt_version
  }
}
