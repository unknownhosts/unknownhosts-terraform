module "dev_vpc" {
  source      = "../../modules/vpc"
  name_prefix = local.name_prefix

  // VPC Configurations
  vpc_cidr_block       = local.vpc_cidr_block
  available_azs        = local.available_azs
  enable_nat_gateway   = local.enable_nat_gateway
  enable_dns_hostnames = local.enable_dns_hostnames
  enable_dns_support   = local.enable_dns_support

  // Subnet Configurations
  public_subnet_cidr  = local.public_subnet_cidr
  private_subnet_cidr = local.private_subnet_cidr

  // ALL Tags
  tags = local.tags

  // Additional Tags
  vpc_tags            = local.vpc_tags
  public_subnet_tags  = local.public_subnet_tags
  private_subnet_tags = local.private_subnet_tags
}