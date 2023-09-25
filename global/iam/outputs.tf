output "first_user_arn" {
  description = "The ARN of the first IAM user"
  value = values(aws_iam_user.iam_user)[0].arn
}

output "arns_of_all_users" {
  description = "The ARNs of all the created users" 
  value = values(aws_iam_user.iam_user)[*].arn
}

output "user_names_upper" {
  description = "Output the result of converting the usernames to uppercase"
  value = [for name in var.user_names: upper(name)]
}

output "short_user_names_upper" {
  description = "Output the result of converting the usernames to uppercase if length of the username is less than 5"
  value = [for name in var.user_names: upper(name) if length(name) < 5]
}

output "bios" {
  description = "Describe the matrix names and roles"
  value = [for name, role in var.hero_thousand_faces: "${name} is the ${role}"]
}

output "mapped_upper_roles" {
  description = "Print out the matrix name and role in a map format"
  value = {for name, role in var.hero_thousand_faces: upper(name) => upper(role)}
}

output "for_directive" {
  description = "Use for directive to print out IAM usernames to create in a string directive"
  value = "%{ for name in var.user_names }${ name } %{ endfor }"
}

output "for_directive_index" {
  description = "for_directive but with the index of the Collection"
  value = "%{ for i, name in var.user_names } (${i}) ${name} %{ endfor }"
}

output "for_directive_if" {
  description = "Use the if directive with the for directive to remove trailing space and comma"
  value = <<EOF
    %{~ for i, name in var.user_names ~}
      ${name} %{ if i < length(var.user_names) -1 }, %{ else }. %{endif}
    %{~ endfor ~}
  EOF
}