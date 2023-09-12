output "first_user_arn" {
  description = "The ARN of the first IAM user"
  value = values(aws_iam_user.iam_user)[0].arn
}

output "arns_of_all_users" {
  description = "The ARNs of all the created users" 
  value = values(aws_iam_user.iam_user)[*].arn
}
