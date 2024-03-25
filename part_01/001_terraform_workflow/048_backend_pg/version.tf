terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
  backend "pg" {
    conn_str = "postgres://postgres:terraform@localhost/terraform?sslmode=disable"
  }
  required_version = ">= 1.6.0"
}