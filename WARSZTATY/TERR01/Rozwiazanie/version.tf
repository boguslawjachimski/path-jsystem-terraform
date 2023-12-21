terraform {
  required_providers {
    ovh = {
      source = "ovh/ovh"
    }

    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
  #backend "pg" {conn_str = "postgres://postgres:terraform@localhost/terraform?sslmode=disable"}
}
