data terraform_remote_state "local" {
  backend = "local"
  config = {
    path = "../example09/terraform.tfstate"
  }
}

resource "local_file" "privkey" {
  content = data.terraform_remote_state.local.outputs.priv_key
  filename = "./private_key"
  file_permission = 0600
}