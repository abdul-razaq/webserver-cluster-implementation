variable "db_username" {
  description = "The master database username"
  type = string
  sensitive = true
}

variable "db_password" {
  description = "The master database password"
  type = string
  sensitive = true
}
