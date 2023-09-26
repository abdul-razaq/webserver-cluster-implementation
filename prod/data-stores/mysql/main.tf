terraform {
  backend "s3" {
    key = "prod/data-stores/mysql/terraform.tfstate"
    bucket = "terraform-state-backend-abdrazaq"
    region = "us-east-2"
    dynamodb_table = "terraform-state-locks"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-2"
  alias = "primary_region"
  default_tags {
    tags = {
      Owner = "Team Antigen"
      ManagedBy = "Terraform"
      Environment = "Primary"
    }
  }
}

provider "aws" {
  region = "us-west-1"
  alias = "replica_region"

  default_tags {
    tags = {
      Owner = "Team Antigen"
      ManagedBy = "Terraform"
      Environment = "Replica"
    }
  }
}

module "primary_database" {
  source = "../../../../modules/data-stores/mysql"
  providers = {
    aws = aws.primary_region
  }

  db_name = "db_prod"
  db_resource_name = "db_prod"

  db_username = var.db_username
  db_password = var.db_password

  backup_retention_period = 1
}

module "replica_database" {
  source = "../../../../modules/data-stores/mysql"

  replicate_source_db = module.primary_database.database_arn
}
