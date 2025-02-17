output "s3_bucket_arns" {
  value = { for k, v in aws_s3_bucket.this : k => v.arn }
}
