provider "aws" {
  # This is how we access variables
  #alias = "eu-central-1"
  region     = "eu-central-1"
  access_key = var.ak
  secret_key = var.sk
}

provider "digitalocean" {
  alias = "inny"
  token = var.token_inny
}

provider "digitalocean" {
  token = var.do_token
}
