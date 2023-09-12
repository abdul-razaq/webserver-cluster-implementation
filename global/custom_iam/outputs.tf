output "admin_policy_details" {
  description = "The Admin Access Policy Details"
  value = data.aws_iam_policy.admin_policy.arn
}

output "iam_user_access_key_id" {
  description = "The Access Key ID of the IAM user"
  value = aws_iam_access_key.iam_user_access_key.id
}

output "iam_user_secret_access_key" {
  description = "The Secret Access Key of the IAM user"
  value = aws_iam_access_key.iam_user_access_key.secret
  sensitive = true
}
