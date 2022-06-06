locals {

  // Remote State
  vpc_id             = data.terraform_remote_state.main["vpc"].outputs.vpc_id
  private_subnet_ids = data.terraform_remote_state.main["vpc"].outputs.private_subnet_ids
  vpc_cidr           = data.terraform_remote_state.main["vpc"].outputs.vpc_cidr

  cluster_version           = var.cluster_version
  cluster_enabled_log_types = var.cluster_enabled_log_types
  enable_irsa               = var.enable_irsa

  cluster_addons = var.cluster_addons

  endpoint_private_access = var.endpoint_private_access
  endpoint_public_access  = var.endpoint_public_access
  public_access_cidrs     = var.public_access_cidrs

  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days

  // Tags
  cluster_tags = {}
}
