output "vpc_id" {
  description = "The ID of the VPC"
  value       = concat(aws_vpc.this.*.id, [""])[0]
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = concat(aws_vpc.this.*.arn, [""])[0]
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = concat(aws_vpc.this.*.cidr_block, [""])[0]
}

output "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = concat(aws_vpc.this.*.default_security_group_id, [""])[0]
}

output "default_network_acl_id" {
  description = "The ID of the default network ACL"
  value       = concat(aws_vpc.this.*.default_network_acl_id, [""])[0]
}

output "default_route_table_id" {
  description = "The ID of the default route table"
  value       = concat(aws_vpc.this.*.default_route_table_id, [""])[0]
}

output "vpc_instance_tenancy" {
  description = "Tenancy of instances spin up within VPC"
  value       = concat(aws_vpc.this.*.instance_tenancy, [""])[0]
}

output "vpc_enable_dns_support" {
  description = "Whether or not the VPC has DNS support"
  value       = concat(aws_vpc.this.*.enable_dns_support, [""])[0]
}

output "vpc_enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  value       = concat(aws_vpc.this.*.enable_dns_hostnames, [""])[0]
}

//output "vpc_enable_classiclink" {
//  description = "Whether or not the VPC has Classiclink enabled"
//  value       = concat(aws_vpc.this.*.enable_classiclink, [""])[0]
//}

output "vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC"
  value       = concat(aws_vpc.this.*.main_route_table_id, [""])[0]
}

output "vpc_ipv6_association_id" {
  description = "The association ID for the IPv6 CIDR block"
  value       = concat(aws_vpc.this.*.ipv6_association_id, [""])[0]
}

output "vpc_ipv6_cidr_block" {
  description = "The IPv6 CIDR block"
  value       = concat(aws_vpc.this.*.ipv6_cidr_block, [""])[0]
}

output "vpc_secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks of the VPC"
  value       = aws_vpc_ipv4_cidr_block_association.this.*.cidr_block
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private.*.id
}




output "private_subnet_arns" {
  description = "List of ARNs of private subnets"
  value       = aws_subnet.private.*.arn
}


output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = aws_subnet.private.*.cidr_block
}

output "private_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of private subnets in an IPv6 enabled VPC"
  value       = aws_subnet.private.*.ipv6_cidr_block
}



output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public.*.id
}

output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.public.*.arn
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = aws_subnet.public.*.cidr_block
}

output "public_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of public subnets in an IPv6 enabled VPC"
  value       = aws_subnet.public.*.ipv6_cidr_block
}

output "public_route_table_ids" {
  description = "List of IDs of public route tables"
  value       = aws_route_table.public.*.id
}

output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = aws_route_table.private.*.id
}

output "nat_ids" {
  description = "List of allocation ID of Elastic IPs created for AWS NAT Gateway"
  value       = aws_eip.nat.*.id
}

output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = aws_eip.nat.*.public_ip
}

output "natgw_ids" {
  description = "List of NAT Gateway IDs"
  value       = aws_nat_gateway.this.*.id
}

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = concat(aws_internet_gateway.this.*.id, [""])[0]
}

output "egress_only_internet_gateway_id" {
  description = "The ID of the egress only Internet Gateway"
  value       = concat(aws_egress_only_internet_gateway.this.*.id, [""])[0]
}

output "cgw_ids" {
  description = "List of IDs of Customer Gateway"
  value       = [for k, v in aws_customer_gateway.this : v.id]
}

output "this_customer_gateway" {
  description = "Map of Customer Gateway attributes"
  value       = aws_customer_gateway.this
}

output "vgw_id" {
  description = "The ID of the VPN Gateway"
  value = concat(
    aws_vpn_gateway.this.*.id,
    aws_vpn_gateway_attachment.this.*.vpn_gateway_id,
    [""],
  )[0]
}

output "default_vpc_id" {
  description = "The ID of the VPC"
  value       = concat(aws_default_vpc.this.*.id, [""])[0]
}

output "default_vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = concat(aws_default_vpc.this.*.cidr_block, [""])[0]
}

output "default_vpc_default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = concat(aws_default_vpc.this.*.default_security_group_id, [""])[0]
}

output "default_vpc_default_network_acl_id" {
  description = "The ID of the default network ACL"
  value       = concat(aws_default_vpc.this.*.default_network_acl_id, [""])[0]
}

output "default_vpc_default_route_table_id" {
  description = "The ID of the default route table"
  value       = concat(aws_default_vpc.this.*.default_route_table_id, [""])[0]
}

output "default_vpc_instance_tenancy" {
  description = "Tenancy of instances spin up within VPC"
  value       = concat(aws_default_vpc.this.*.instance_tenancy, [""])[0]
}

output "default_vpc_enable_dns_support" {
  description = "Whether or not the VPC has DNS support"
  value       = concat(aws_default_vpc.this.*.enable_dns_support, [""])[0]
}

output "default_vpc_enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  value       = concat(aws_default_vpc.this.*.enable_dns_hostnames, [""])[0]
}

//output "default_vpc_enable_classiclink" {
//  description = "Whether or not the VPC has Classiclink enabled"
//  value       = concat(aws_default_vpc.this.*.enable_classiclink, [""])[0]
//}

output "default_vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC"
  value       = concat(aws_default_vpc.this.*.main_route_table_id, [""])[0]
}

//output "default_vpc_ipv6_association_id" {
//  description = "The association ID for the IPv6 CIDR block"
//  value       = concat(aws_default_vpc.this.*.ipv6_association_id, [""])[0]
//}
//
//output "default_vpc_ipv6_cidr_block" {
//  description = "The IPv6 CIDR block"
//  value       = concat(aws_default_vpc.this.*.ipv6_cidr_block, [""])[0]
//}

output "public_network_acl_id" {
  description = "ID of the public network ACL"
  value       = concat(aws_network_acl.public.*.id, [""])[0]
}

output "private_network_acl_id" {
  description = "ID of the private network ACL"
  value       = concat(aws_network_acl.private.*.id, [""])[0]
}


# Static values (arguments)
output "azs" {
  description = "A list of availability zones specified as argument to this module"
  value       = var.azs
}

output "name" {
  description = "The name of the VPC specified as argument to this module"
  value       = var.name
}
