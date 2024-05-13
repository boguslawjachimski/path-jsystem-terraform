terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.35.0"
    } 
  }
  backend "pg" {
    conn_str = "postgresql://postgres:terraform@localhost:5432/terraform?sslmode=disable"
  }
}