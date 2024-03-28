terraform {
    required_providers {
        digitalocean = {
            source  = "digitalocean/digitalocean"
            version = "2.5.0"
        }
    }
    cloud {
      organization = "Szkolenia"

      workspaces {
        name = "test2"
      }
    }
}