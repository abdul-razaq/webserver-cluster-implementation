variable "iam_users" {
  description = "The IAM users to create"
  type = list(string)
  default = [ "Antigen", "Nivans", "Biohazard" ]
}
