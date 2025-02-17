variable "lambda_name" {
  description = "Lambda function name"
  type        = string
  default     = null
}

variable "lambda_role_arn" {
  description = "IAM Role ARN for Lambda"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Lambda function"
  type        = list(string)
  default     = null
}

variable "security_group_id" {
  description = "Security Group ID for the Lambda function"
  type        = string
  default     = null
}

variable "vpc_id" {
  type    = string
  default = null
}
