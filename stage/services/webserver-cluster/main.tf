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
    key = "stage/services/webserver-cluster/terraform.tfstate"  
  }
}

module "webserver_cluster" {
  source = "../../../../modules/services/webserver-cluster"

  cluster_name = "webservers-stage"
  db_remote_state_bucket = "terraform-state-backend-abdrazaq"
  db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size = 2
  max_size = 2

  custom_tags ={
    Owner = "Team Antigen"
    ManagedBy = "Terraform"
  }
} 

resource "aws_security_group_rule" "allow_inbound_testing" {
  security_group_id = module.webserver_cluster.alb_security_group_id
  type = "ingress"

  from_port = 12345
  to_port = 12345
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
