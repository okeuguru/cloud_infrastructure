resource "aws_s3_bucket" "this" {
  for_each = var.s3_buckets
  bucket   = each.value.name
  force_destroy = true
}

resource "aws_s3_bucket_policy" "this" {
  for_each = aws_s3_bucket.this

  bucket = each.value.bucket
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowLambdaReadAccess"
        Effect    = "Allow"
        Principal = { AWS = var.lambda_role_arn }
        Action    =    [
          "s3:GetObject",
          "s3:ListBucket"
      ]
        Resource = [
          "arn:aws:s3:::${each.value.bucket}",
          "arn:aws:s3:::${each.value.bucket}/*"
        ],
        Condition: {
          StringEquals: {
            "aws:SourceVpc" = var.vpc_id
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket_notification" "lambda_trigger" {
  for_each = aws_s3_bucket.this

  bucket = aws_s3_bucket.this[each.key].id

  lambda_function {
    lambda_function_arn = var.lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
  }
  depends_on = [var.lambda_function_arn, aws_lambda_permission.allow_s3]
}

resource "aws_lambda_permission" "allow_s3" {
  for_each = aws_s3_bucket.this

  statement_id  = "AllowS3InvokeLambda-${each.value.bucket}"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.this[each.key].arn
}