module "eks_cluster" {
  source = "../../../modules/eks/cluster"

  # EKS Cluster
  cluster_name              = "${local.name_prefix}-cluster"
  cluster_version           = local.cluster_version
  cluster_enabled_log_types = local.cluster_enabled_log_types
  enable_irsa               = local.enable_irsa


  # EKS Addons
  cluster_addons = local.cluster_addons

  # EKS Network Config
  vpc_id   = local.vpc_id
  vpc_cidr = local.vpc_cidr

  subnet_ids              = local.private_subnet_ids
  endpoint_private_access = local.endpoint_private_access
  endpoint_public_access  = local.endpoint_public_access
  public_access_cidrs     = local.public_access_cidrs

  # ClousWatch Logs
  cloudwatch_log_group_retention_in_days = local.cloudwatch_log_group_retention_in_days

  # Tags
  tags         = local.tags
  cluster_tags = local.cluster_tags
}