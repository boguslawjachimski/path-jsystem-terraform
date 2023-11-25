# This file is used to define the providers that will be used in the Terraform configuration.
provider "digitalocean" {
  alias = "do"
  token = var.do_token
}

provider "digitalocean" {
  token = var.do_token
}