# Deklaracja używanej wersji terraforma oraz dostawcy digitalocean
terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "= 2.32.0"
    }
  }
  required_version = ">= 0.14.0"
}