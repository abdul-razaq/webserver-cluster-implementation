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
    region = "us-east-2"
    dynamodb_table = "terraform-state-locks"
    encrypt = true
    key = "prod/services/webserver-cluster/terraform.tfstate"  
  }
}

module "webserver_cluster" {
  source = "../../../../modules/services/webserver-cluster"

  cluster_name = "webservers-prod"
  db_remote_state_key = "prod/data-stores/mysql/terraform.tfstate"
  db_remote_state_bucket = "terraform-state-backend-abdrazaq"

  instance_type = "t2.micro"
  min_size = 2
  max_size = 10

  custom_tags = {
    Owner = "Team Antigen"
    ManagedBy = "Terraform"
  }

  enable_autoscaling = true
} 
