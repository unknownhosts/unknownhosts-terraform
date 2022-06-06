////////////////////////////////////////////////
// VPC Outputs
////////////////////////////////////////////////
output "vpc_id" {
  value       = aws_vpc.this.id
  description = "Output details of my newly crated VPC Id"
}

output "vpc_cidr_block" {
  description = "Output details of my newly crated VPC CIDR"
  value       = concat(aws_vpc.this.*.cidr_block, [""])[0]
}

output "vpc_enable_dns_support" {
  description = "Whether or not the VPC has DNS support"
  value       = concat(aws_vpc.this.*.enable_dns_support, [""])[0]
}

output "vpc_enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  value       = concat(aws_vpc.this.*.enable_dns_hostnames, [""])[0]
}

////////////////////////////////////////////////
// Subnet Outputs
////////////////////////////////////////////////

////////////////////////////////////////////////
// 1. Public Subnet
////////////////////////////////////////////////
output "public_subnets_ids" {
  value       = aws_subnet.public.*.id
  description = "Output details of my public subnets"
}

output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.public.*.arn
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = aws_subnet.public.*.cidr_block
}

////////////////////////////////////////////////
// 2. Private Subnet
////////////////////////////////////////////////
output "private_subnets_ids" {
  description = "Output details of my private subnets"
  value       = try(aws_subnet.private.*.id)
}

output "private_subnet_arns" {
  description = "List of ARNs of private subnets"
  value       = try(aws_subnet.private.*.arn)
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = try(aws_subnet.private.*.cidr_block)
}

////////////////////////////////////////////////
// 3. Database Subnet
////////////////////////////////////////////////
output "db_subnets_ids" {
  description = "Output details of my Database subnets"
  value       = try(aws_subnet.db.*.id)
}

output "database_subnet_arns" {
  description = "List of ARNs of database subnets"
  value       = try(aws_subnet.db.*.arn)
}

output "database_subnets_cidr_blocks" {
  description = "List of cidr_blocks of database subnets"
  value       = try(aws_subnet.db.*.cidr_block)
}

////////////////////////////////////////////////
// IGW
////////////////////////////////////////////////
output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = concat(aws_internet_gateway.this.*.id, [""])[0]
}

output "igw_arn" {
  description = "The ARN of the Internet Gateway"
  value       = concat(aws_internet_gateway.this.*.arn, [""])[0]
}

////////////////////////////////////////////////
// NAT GW
////////////////////////////////////////////////
output "natgw_ids" {
  description = "List of NAT Gateway IDs"
  value       = try(aws_nat_gateway.this.*.id)
}

////////////////////////////////////////////////
// Route Table IDs
////////////////////////////////////////////////
output "public_route_table_ids" {
  description = "List of IDs of public route tables"
  value       = aws_route_table.public.*.id
}

output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = try(aws_route_table.private.*.id)
}

output "database_route_table_ids" {
  description = "List of IDs of database route tables"
  value       = try(coalescelist(aws_route_table.db[*].id, aws_route_table.private[*].id), [])
}
