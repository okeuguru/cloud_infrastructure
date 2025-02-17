#------------------------------------------------------------------------------
# AWS Virtual Private Network (VPC)
#------------------------------------------------------------------------------
output "vpc_arn" {
  description = "Amazon Resource Name (ARN) of VPC"
  value       = aws_vpc.vpc.arn
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC"
  value       = aws_vpc.vpc.main_route_table_id
}

output "vpc_default_network_acl_id" {
  description = "The ID of the network ACL created by default on VPC creation"
  value       = aws_vpc.vpc.default_network_acl_id
}

output "vpc_default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = aws_vpc.vpc.default_security_group_id
}

output "vpc_default_route_table_id" {
  description = "The ID of the route table created by default on VPC creation"
  value       = aws_vpc.vpc.default_route_table_id
}

output "vpc_ipv6_association_id" {
  description = "The association ID for the IPv6 CIDR block."
  value       = aws_vpc.vpc.ipv6_association_id
}

output "vpc_owner_id" {
  description = "The ID of the AWS account that owns the VPC."
  value       = aws_vpc.vpc.owner_id
}

output "vpc_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = aws_vpc.vpc.tags
}

#------------------------------------------------------------------------------
# AWS Internet Gateway
#------------------------------------------------------------------------------
output "internet_gateway_id" {
  description = "ID of the generated Internet Gateway"
  value       = aws_internet_gateway.internet_gw.id
}

#------------------------------------------------------------------------------
# AWS Subnets - Public
#------------------------------------------------------------------------------
output "public_subnets" {
  value = aws_subnet.public
}

output "public_subnets_route_tables" {
  value = aws_route_table.public
}

output "public_subnets_route_tables_gateway_id" {
  value = { for k, v in aws_route.public_internet: k => v.gateway_id }
}

output "nat_gws" {
  value = aws_nat_gateway.nat
}

#------------------------------------------------------------------------------
# AWS Subnets - Private
#------------------------------------------------------------------------------
output "private_subnets" {
  value = aws_subnet.private
}

output "private_subnet_id" {
  value = aws_subnet.private["gb_subnet"].id
}

output "private_subnets_route_tables" {
  value = aws_route_table.private
}