// Shared Variables
region  = "ap-southeast-1"
account = "sandbox"
tags    = {}

// VPC Configuration
vpc_cidr_block       = "10.130.0.0/16"
enable_nat_gateway   = true
enable_dns_hostnames = true
enable_dns_support   = true

// Subnet Configuration
public_subnet_cidr  = ["10.130.0.0/24", "10.130.1.0/24"]
private_subnet_cidr = ["10.130.10.0/24", "10.130.11.0/24"]

// Tags
public_subnet_tags = {
  "kubernetes.io/role/elb" = 1
}

private_subnet_tags = {
  "kubernetes.io/role/internal-elb" = 1
}