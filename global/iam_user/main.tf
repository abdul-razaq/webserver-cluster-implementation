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
    bucket = "terraform-state-backend-abdrazaq"
    key = "global/iam_user/terraform.tfstate"
    dynamodb_table = "terraform-state-locks"
    encrypt = true
    region = "us-east-2"
  }
}

module "iam_user" {
  source = "../../../modules/landing_zone/iam_user"

  for_each = toset(var.iam_users)
  iam_user = each.value
}
