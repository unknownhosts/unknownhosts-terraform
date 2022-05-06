module "vpc" {
  source = "./modules/vpc"

  name = "${var.env_name}-${var.account_name}"
  cidr = "${var.vpc_cidr}"

  azs             = "${var.vpc_azs}"
  public_subnets  = "${var.public_cidr}"
  private_subnets = "${var.private_cidr}"

  enable_nat_gateway = true
  enable_vpn_gateway = false
  single_nat_gateway  = true
  one_nat_gateway_per_az = false
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    createdBy = "unknowhosts"
  }
}