provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket = "terraform-state-backend-abdrazaq"
    key = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "terraform-state-locks"
    encrypt = true
  }
} 

module "db_instance_stage" {
  source = "github.com/abdul-razaq/webserver-cluster//data-stores/mysql?ref=v1.0.0"

  db_resource_name = "db_stage"
  db_name = "db_stage"

  db_username = var.db_username
  db_password = var.db_password
}
