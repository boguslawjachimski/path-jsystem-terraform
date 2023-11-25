locals {
    # get json 
    user_data = jsondecode(file("./_files/users.json"))

    # get all users
    all_users = [for user in local.user_data.users : user.user_name]
}

output "users" {
    value = local.all_users
}