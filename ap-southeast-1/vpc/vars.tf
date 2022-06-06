////////////////////////////////////
// VPC
////////////////////////////////////
variable "vpc_cidr_block" {}
variable "enable_nat_gateway" {}
variable "enable_dns_hostnames" {}
variable "enable_dns_support" {}


////////////////////////////////////
// Subnet
////////////////////////////////////
variable "public_subnet_cidr" {}
variable "private_subnet_cidr" {}


////////////////////////////////////
// Tags
////////////////////////////////////
variable "vpc_tags" { default = {} }
variable "public_subnet_tags" { default = {} }
variable "private_subnet_tags" { default = {} }
