provider "aws" {
  region = "us-east-2"
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

  count = length(var.iam_users)
  iam_user = var.iam_users[count.index]
}
