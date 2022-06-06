locals {

  ////////////////////////////////////
  // VPC
  ////////////////////////////////////
  vpc_cidr_block       = var.vpc_cidr_block
  enable_nat_gateway   = var.enable_nat_gateway
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  available_azs        = [data.aws_availability_zones.this.names[0], data.aws_availability_zones.this.names[2]]


  ////////////////////////////////////
  // Subnets CIDR
  ////////////////////////////////////
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr


  ////////////////////////////////////
  // Tags
  ////////////////////////////////////
  vpc_tags = merge(
    var.vpc_tags
  )

  public_subnet_tags = merge(
    var.public_subnet_tags
  )

  private_subnet_tags = merge(
    var.private_subnet_tags
  )
}