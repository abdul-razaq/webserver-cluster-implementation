output "iam_users_arns" {
  description = "The ARN of the IAM users created"
  value = module.iam_user[*].iam_users_arns
}
