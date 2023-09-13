variable "user_names" {
  description = "names of IAM users to create"
  type = list(string)
  default = [ "Neo", "Trinity", "Morpheus" ]
}

variable "hero_thousand_faces" {
  description = "map"
  type = map(string)
  default = {
    neo = "hero"
    trinity = "love interest"
    morpheus = "mentor"
  }
}
