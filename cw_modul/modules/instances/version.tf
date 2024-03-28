terraform {
    required_version = "= 1.7.5"
    required_providers {
      digitalocean = {
        source  = "registry.terraform.io/digitalocean/digitalocean"
        version = "2.5.0"
      }
    }
}