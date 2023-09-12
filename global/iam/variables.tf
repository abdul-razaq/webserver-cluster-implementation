variable "user_names" {
  description = "names of IAM users to create"
  type = list(string)
  default = [ "Neo", "Trinity", "Morpheus" ]
}
