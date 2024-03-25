terraform {
}

locals {
  admins = {
    piotr  = "piotr@gmail.com"
    adam = "adam@gmail.com"
  }
  users = {
    marcin  = "marcin@gmail.com"
    pawel = "pawel@gmail.com"
  }
}


resource "local_file" "user_data" {
  content  = jsonencode({ admins = local.admins, users = local.users })
  filename = "${path.module}/user_data.json" 
}