provider "aws" {
  region = "us-east-2"

  default_tags {
    tags = {
      Owner = "Team Antigen"
      ManagedBy = "Terraform"
    }
  }
}

terraform {
  backend "s3" {
    region = "us-east-2"
    bucket = "terraform-state-backend-abdrazaq"
    key = "global/iam_user/terraform.tfstate"
    dynamodb_table = "terraform-state-locks"
    encrypt = true
  }
}

module "iam_user" {
  source = "../../../modules/landing_zone/iam_user"

  for_each = toset(var.iam_users)
  iam_user = each.value

  give_user_cloudwatch_full_access = var.iam_users[0] ? true : false
}
