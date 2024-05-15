terraform {
  required_version = ">= 1.8.3"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.38.0"
    }
  }
}