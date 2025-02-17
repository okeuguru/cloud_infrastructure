#------------------------------------------------------------------------------
# AWS Virtual Private Network (VPC)
#------------------------------------------------------------------------------

# VPC
resource "aws_vpc" "vpc" {
  # IPv4
  cidr_block          = var.cidr_block

  # Tags
  tags = merge(
  {
    Name = "Grubber Main VPC"
  },
  var.additional_tags,
  var.vpc_additional_tags,
  )
}

# Internet Gateway
resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.vpc.id
}

#------------------------------------------------------------------------------
# Private Subnets
#------------------------------------------------------------------------------

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  availability_zone       = each.value.availability_zone
  cidr_block              = each.value.cidr_block
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = false
  tags = merge(
  var.additional_tags,
  {
    Name = "private-${each.key}"
  },
  var.private_subnets_additional_tags
  )
}

#------------------------------------------------------------------------------
# Route tables
#------------------------------------------------------------------------------

# Route table
resource "aws_route_table" "private" {
  for_each = aws_subnet.private

  vpc_id = aws_vpc.vpc.id
  tags = merge(
  var.additional_tags,
  {
    Name = "private-rt-${each.key}"
  },
  )
}

# Route to access internet
resource "aws_route" "private_internet_route" {
  for_each = aws_route_table.private

  route_table_id         = each.value.id
  destination_cidr_block = "0.0.0.0/0"

  # Zipmap to create map between public and private ids
  nat_gateway_id = aws_nat_gateway.nat[zipmap(keys(aws_subnet.private), keys(aws_subnet.public))[each.key]].id
}

# Association of Route Table to Subnets
resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}

#------------------------------------------------------------------------------
# S3 endpoint
#------------------------------------------------------------------------------

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.us-east-1.s3"
}
# associate route table with VPC endpoint
resource "aws_vpc_endpoint_route_table_association" "Private_route_table_association" {
  for_each = aws_route_table.private

  route_table_id  = aws_route_table.private[each.key].id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}

#------------------------------------------------------------------------------
# Public Subnets
#------------------------------------------------------------------------------
resource "aws_subnet" "public" {
  for_each = var.public_subnets

  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block

  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = merge(
  var.additional_tags,
  {
    Name = "public-${each.key}"
  },
  var.public_subnets_additional_tags
  )
}

#------------------------------------------------------------------------------
# NAT
#------------------------------------------------------------------------------
# Elastic IPs for NAT
resource "aws_eip" "nat" {
  for_each = var.single_nat ? { keys(aws_subnet.public)[0] = values(aws_subnet.public)[0] } : aws_subnet.public

  domain = "vpc"

  tags = merge(
  var.additional_tags,
  {
    Name = "nat-eip-${each.key}"
  },
  )
}

# NAT gateways
resource "aws_nat_gateway" "nat" {
  for_each = var.single_nat ? { keys(aws_subnet.public)[0] = values(aws_subnet.public)[0] } : aws_subnet.public

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = aws_subnet.public[each.key].id

  tags = merge(
  var.additional_tags,
  {
    Name = "nat-gw-${each.key}"
  },
  )
}

#------------------------------------------------------------------------------
# Route tables
#------------------------------------------------------------------------------

# Route table
resource "aws_route_table" "public" {
  for_each = aws_subnet.public

  vpc_id = aws_vpc.vpc.id
  tags = merge(
  var.additional_tags,
  {
    Name = "public-rt-${each.key}"
  },
  )
}

# Route to access internet
resource "aws_route" "public_internet" {
  for_each = aws_route_table.public

  route_table_id         = each.value.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gw.id

  depends_on = [aws_internet_gateway.internet_gw]
}

# Association of Route Table to Subnets
resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public[each.key].id
}