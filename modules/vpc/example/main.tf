module "dev_vpc" {
  source      = ""
  name_prefix = "ai-dev"

  // VPC Configurations
  vpc_cidr_block       = "10.0.0.0/16"
  available_azs        = ["ap-northeast-2a", "ap-northeast-2c"]
  enable_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  // Subnet Configurations
  public_subnet_cidr  = ["10.0.0.0/24", "10.0.1.0/24"]
  private_subnet_cidr = ["10.0.10.0/24", "10.0.11.0/24"]

  // ALL Tags
  tags = { }

  // Additional Tags
  vpc_tags            = { }
  public_subnet_tags  = { }
  private_subnet_tags = { }
}
