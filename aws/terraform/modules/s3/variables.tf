variable "s3_buckets" {
  description = "Map of S3 buckets to create"
  type        = map(object({
    name = string
  }))
}

variable "lambda_function_arn" {
  description = "Lambda function ARN"
  type        = string
}

variable "function_name" {
  description = "Lambda function name"
  type        = string
}

variable "lambda_role_arn" {
  description = "IAM Role ARN for Lambda"
  type        = string
}

variable "vpc_id" {
  type    = string
  default = null
}

variable "aws_region" {
  type        = string
  description = "(Required) AWS Region"
  default     = "us-east-1"
}