provider "aws" {
  region = "us-east-2"

  default_tags {
    tags = {
      Owner = "Team Antigen"
      ManagedBy = "Terraform"
    }
  }
}

resource "aws_iam_user" "iam_user" {
  for_each = toset(var.user_names)
  name = each.value
}
