terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
  backend "pg" {
    conn_str = "postgresql://postgres:terraform@localhost:5432/terraform?sslmode=disable"
  }
  required_version = ">= 1.6.0"
}

resource "digitalocean_project" "test" {
  name = "test-piotr-koska"
}

resource "digitalocean_project" "test2" {
  name = "test-piotr-koska2"
}

