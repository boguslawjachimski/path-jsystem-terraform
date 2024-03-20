locals {    
    uniq_dev_roles = distinct(
      [for user in var.users.users : user.role]
    )
}

variable "users" {}

output "roles" {
    value = local.uniq_dev_roles
}