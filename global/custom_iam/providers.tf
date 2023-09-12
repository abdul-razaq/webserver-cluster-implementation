provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      OwnedBy = "Team Antigen"
      ManagedBy = "Terraform"
      ToBeUsedFor = "Interacting with AWS with the aws cli"
    }
  }
}

terraform {
  backend "s3" {
    region = "us-east-2"
    encrypt = true
    bucket = "terraform-state-backend-abdrazaq"
    key = "global/custom_iam/terraform.tfstate"
    dynamodb_table = "terraform-state-locks"
  }
}
