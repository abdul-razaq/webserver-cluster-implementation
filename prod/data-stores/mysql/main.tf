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
    key = "prod/data-stores/mysql/terraform.tfstate"
    bucket = "terraform-state-backend-abdrazaq"
    region = "us-east-2"
    dynamodb_table = "terraform-state-locks"
    encrypt = true
  }
} 

module "db_instance_prod" {
  source = "github.com/abdul-razaq/webserver-cluster//data-stores/mysql?ref=v1.0.0"

  db_name = "db_prod"
  db_resource_name = "db_prod"

  db_username = var.db_username
  db_password = var.db_password
}
