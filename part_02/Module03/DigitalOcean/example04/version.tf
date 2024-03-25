terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# the provider block
provider "digitalocean" {
  token = var.do_token # this is adress of the variable
}
