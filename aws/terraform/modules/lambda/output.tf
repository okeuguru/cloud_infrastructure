output "lambda_arn" {
  value = aws_lambda_function.this.arn
}

output "lambda_name" {
  value = aws_lambda_function.this.function_name
}

output "lambda_function_arn" {
  value = aws_lambda_function.this.arn
}

output "lambda_sg" {
  value = aws_security_group.lambda_sg.id
}

output "lambda_exec_role_arn" {
  value = aws_iam_role.lambda_exec.arn
}