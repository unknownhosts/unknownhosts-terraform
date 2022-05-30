module "vpc" {
  source = "../../../../../../modules/vpc"

  name = "${var.project_name}-${var.vpcs_name}"
  cidr = var.vpc_cidr
  secondary_cidr_blocks = var.secondary_cidr
  private_subnet_index = var.private_subnet_index

  azs             = var.private_subnet_azs
  public_subnets  = var.public_cidr
  private_subnets = var.private_cidr

  public_subnet_suffix = var.public_subnet_suffix
  public_route_suffix = var.public_route_suffix

  private_subnet_suffix = var.private_subnet_suffix
  private_route_suffix = var.private_route_suffix

  enable_nat_gateway = true
  enable_vpn_gateway = false
  single_nat_gateway  = true
  one_nat_gateway_per_az = false
  enable_dns_hostnames = true
  enable_dns_support = true

}