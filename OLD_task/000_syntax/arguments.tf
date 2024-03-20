terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean" # This is a argument
      version = "~> 2.0"
    }
  }
  required_version = ">= 0.14.0"
}