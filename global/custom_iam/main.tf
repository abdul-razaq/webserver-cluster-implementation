resource "aws_iam_user" "iam_user" {
  name = "awscli"

  tags = {
    Purpose = "Manage AWS resources via CLI"
  }
}

resource "aws_iam_user_policy_attachment" "managed_policy_attachment" {
  user = aws_iam_user.iam_user.name
  policy_arn = data.aws_iam_policy.admin_policy.arn
}

resource "aws_iam_access_key" "iam_user_access_key" {
  user = aws_iam_user.iam_user.name
  status = "Active"
}
