////////////////////////////////////////////////
// Tags
////////////////////////////////////////////////
variable "tags" {
  description = "Tags to All VPC Module Resources."
  type        = map(string)
  default     = {}
}

////////////////////////////////////////////////
// VPC
////////////////////////////////////////////////
variable "name_prefix" {
  type        = string
  description = "Name Prefix for VPC Module Resource. ex) avocado-dev"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block for the VPC. ex) 10.10.0.0/16"
}

variable "vpc_tags" {
  description = "Tags Only applied to VPC"
  type        = map(string)
  default     = {}
}

////////////////////////////////////////////////
// VPC Settings
////////////////////////////////////////////////
variable "map_public_ip_on_launch" {
  description = "Should be false if you do not want to auto-assign public IP on launch"
  type        = bool
  default     = true
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Whether to Enable DNS Hostname"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS Support"
  type        = bool
  default     = true
}

variable "enable_nat_gateway" {
  description = "Whether to Enable NAT Gateway"
  type        = bool
}

////////////////////////////////////////////////
// Availability Zone
////////////////////////////////////////////////
variable "available_azs" {
  description = "Availibility zones. ex) ['ap-northeast-2', 'ap-northeast-2c']"
  type        = list(string)
}

////////////////////////////////////////////////
// Public Subnets
////////////////////////////////////////////////
variable "public_subnet_cidr" {
  description = "Subnet CIDRs for public subnets (length must match configured availability_zones)"
  type        = list(any)
  default     = []
}

variable "public_subnet_tags" {
  description = "Tags only applied to Public Subnets"
  type        = map(string)
  default     = {}
}

////////////////////////////////////////////////
// Private Subnet
////////////////////////////////////////////////
variable "private_subnet_cidr" {
  description = "Subnet CIDRs for private subnets (length must match configured availability_zones)"
  type        = list(any)
  default     = []
}

variable "private_subnet_tags" {
  description = "Tags only applied to Private Subnets"
  type        = map(string)
  default     = {}
}

////////////////////////////////////////////////
// DB Subnet
////////////////////////////////////////////////
variable "db_subnet_cidr" {
  description = "Subnet CIDRs for DB Subnets (length must match configured availability_zones)"
  type        = list(any)
  default     = []
}

variable "db_subnet_tags" {
  description = "Tags only applied to Database Subnets"
  type        = map(string)
  default     = {}
}
