output "lambda_role_arn" {
  description = "Role for CloudCustodian lambdas"
  value       = aws_iam_role.cloudcustodian_lambda_role.arn
}

output "cloudcustodian_bucket" {
  description = "Bucket for CloudCustodian lambdas logs"
  value       =  aws_s3_bucket.cloudcustodian_bucket
}


