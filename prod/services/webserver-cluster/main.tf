provider "aws" {
  region = "us-east-2"
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
  source = "github.com/abdul-razaq/webserver-cluster//services/webserver-cluster?ref=v1.0.0"

  cluster_name = "webservers-prod"
  db_remote_state_key = "prod/data-stores/mysql/terraform.tfstate"
  db_remote_state_bucket = "terraform-state-backend-abdrazaq"

  instance_type = "t2.micro"
  min_size = 2
  max_size = 10
} 

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name = "scale-out-during-business-hours"
  min_size = 2
  max_size = 10
  desired_capacity = 10
  recurrence = "0 9 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name = "scale-in-at-night"
  min_size = 2
  max_size = 10
  desired_capacity = 2
  recurrence = "0 17 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name
}
