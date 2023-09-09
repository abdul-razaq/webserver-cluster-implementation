variable "db_username" {
  type = string
  description = "The master database username"
  sensitive = true
}

variable "db_password" {
  type = string
  description = "The master database password"
  sensitive = true
}
