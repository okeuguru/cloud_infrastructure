#------------------------------------------------------------------------------
# Access
#------------------------------------------------------------------------------

variable "region" {
  type        = string
  description = "(Required) AWS Region"
  default     = null
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
  description = "(Required) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using ipv4_netmask_length"
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
  description = "(Optional) Map of objects contining the definition for each private subnet"
  default     = {}
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
  description = "(Optional) Map of objects contining the definition for each public subnet"
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

#------------------------------------------------------------------------------
# S3
#------------------------------------------------------------------------------

variable "s3_buckets" {
  description = "Map of S3 buckets to create"
  type        = map(object({
    name = string
  }))
}

variable "vpc_endpoint" {
  type    = string
  default = null
}

#------------------------------------------------------------------------------
# lambda
#------------------------------------------------------------------------------

variable "lambda_function_arn" {
  description = "Lambda function ARN"
  type        = string
  default     = null
}

variable "lambda_function_name" {
  description = "Lambda function name"
  type        = string
  default     = null
}

variable "lambda_role_arn" {
  description = "IAM Role ARN for Lambda"
  type        = string
  default     = null
}

variable "security_group_id" {
  description = "Security Group ID for the Lambda function"
  type        = string
  default     = null
}