#------------------------------------------------------------------------------
# Access
#------------------------------------------------------------------------------

variable "aws_region" {
  type        = string
  description = "(Required) AWS Region"
  default     = "us-east-1"
}

variable "access_key" {
  type        = string
  description = "(Required) AWS Access Key"
  default     = null
}
variable "secret_key" {
  type        = string
  description = "(Required) AWS Secret Key"
  default     = null
}

#------------------------------------------------------------------------------
# AWS Virtual Private Network (VPC)
#------------------------------------------------------------------------------
variable "cidr_block" {
  type        = string
  description = "(Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using ipv4_netmask_length"
  default     = null
}

variable "vpc_additional_tags" {
  type        = map(string)
  description = "(Optional) A map of tags to assign to the VPC resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  default     = {}
}

#------------------------------------------------------------------------------
# Private Subnets
#------------------------------------------------------------------------------
variable "private_subnets" {
  type = map(object({
    availability_zone = string # Availability Zone for the subnet.
    cidr_block        = string # The IPv4 CIDR block for the subnet.
  }))
  description = "(Optional) Map of objects with the definition for each private subnet"
  default     = {}
}

variable "private_subnet_id" {
  type = list(string)
  default = null
}

variable "private_subnets_additional_tags" {
  type        = map(string)
  description = "(Optional) A map of tags to assign to the resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  default     = {}
}

variable "additional_tags" {
  type        = map(string)
  description = "(Optional) A map of tags to assign to all the resources. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  default     = {}
}

#------------------------------------------------------------------------------
# Public Subnets
#------------------------------------------------------------------------------
variable "public_subnets" {
  type = map(object({
    availability_zone = string # Availability Zone for the subnet.
    cidr_block        = string # The IPv4 CIDR block for the subnet.
  }))
  description = "(Optional) Map of objects with the definition for each public subnet"
  default     = {}
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "(Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is false."
  default     = false
}

variable "public_subnets_additional_tags" {
  type        = map(string)
  description = "(Optional) A map of tags to assign to the resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  default     = {}
}

variable "single_nat" {
  type        = bool
  description = "Use single NAT Gateway"
  default     = false
}