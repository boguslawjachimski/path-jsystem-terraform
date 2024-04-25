terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.35.0"
    } 
  }
  cloud {
      organization = "test2piotrkoska"

      workspaces {
        name = "szkolenie"
      }
  }
}