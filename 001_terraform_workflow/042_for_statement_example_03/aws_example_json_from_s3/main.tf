data "aws_s3_object" "user_access_data" {
  provider = aws
  bucket = "moj-unikalny-nazwa-bucket"
  key    = "myusers/users.json"
}

locals {    
    user_data = jsondecode(data.aws_s3_object.user_access_data.body)
    users = [for user in local.user_data.users: user.user_name]
}

# create an IAM user for each user found in the JSON
resource "aws_iam_user" "user" {
    for_each = toset(local.users)
    name = each.value
}