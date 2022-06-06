output "vpc_id" {
  value = module.dev_vpc.vpc_id
}

output "vpc_cidr" {
  value = module.dev_vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  value = module.dev_vpc.public_subnets_ids
}

output "private_subnet_ids" {
  value = module.dev_vpc.private_subnets_ids
}

output "public_route_table_ids" {
  value = module.dev_vpc.public_route_table_ids
}

output "private_route_table_ids" {
  value = module.dev_vpc.private_route_table_ids
}
