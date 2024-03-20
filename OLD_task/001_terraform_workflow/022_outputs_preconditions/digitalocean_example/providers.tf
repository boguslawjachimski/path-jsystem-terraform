# This file is used to define the providers that will be used in the Terraform configuration
provider "digitalocean" {
  token = var.do_token
}