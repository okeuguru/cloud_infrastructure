#------------------------------------------------------------------------------
# AWS Virtual Private Network (VPC)
#------------------------------------------------------------------------------
output "vpc_arn" {
  description = "Amazon Resource Name (ARN) of VPC"
  value       = module.network.vpc_arn
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.network.vpc_id
}

output "vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC. Note that you can change a VPC's main route table by using an aws_main_route_table_association."
  value       = module.network.vpc_main_route_table_id
}

output "vpc_default_network_acl_id" {
  description = "The ID of the network ACL created by default on VPC creation"
  value       = module.network.vpc_default_network_acl_id
}

output "vpc_default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = module.network.vpc_default_security_group_id
}

output "vpc_default_route_table_id" {
  description = "The ID of the route table created by default on VPC creation"
  value       = module.network.vpc_default_route_table_id
}

output "vpc_ipv6_association_id" {
  description = "The association ID for the IPv6 CIDR block."
  value       = module.network.vpc_ipv6_association_id
}

//output "vpc_ipv6_cidr_block_network_border_group" {
//  description = "The Network Border Group Zone name"
//  value       = module.network.vpc_ipv6_cidr_block_network_border_group
//}

output "vpc_owner_id" {
  description = "The ID of the AWS account that owns the VPC."
  value       = module.network.vpc_owner_id
}

output "vpc_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = module.network.vpc_tags_all
}

#------------------------------------------------------------------------------
# AWS Internet Gateway
#------------------------------------------------------------------------------
output "internet_gateway_id" {
  description = "ID of the generated Internet Gateway"
  value       = module.network.internet_gateway_id
}

#------------------------------------------------------------------------------
# AWS Subnets - Public
#------------------------------------------------------------------------------
output "public_subnets" {
  value = module.network.public_subnets
}

output "public_subnets_route_tables" {
  value = module.network.public_subnets_route_tables
}

output "nat_gws" {
  value = module.network.nat_gws
}

#------------------------------------------------------------------------------
# AWS Subnets - Private
#------------------------------------------------------------------------------
output "private_subnets" {
  value = module.network.private_subnets
}

output "private_subnets_route_tables" {
  value = module.network.private_subnets_route_tables
}

output "s3_bucket_arns" {
  value = module.s3.s3_bucket_arns
}