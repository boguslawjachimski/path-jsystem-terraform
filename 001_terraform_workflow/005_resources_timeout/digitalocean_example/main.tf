# Project
resource "digitalocean_project" "student_projekt" {
  name        = "stf-pio-kos-development"
  description = "Project for student Piotr Koska"
  purpose     = "Project for learning Terraform"
  environment = "development"
}

# VPC
resource "digitalocean_vpc" "student_network" {
  name        = "stf-pio-kos-development-fra1-net"
  region      = "fra1"
  description = "VPC for region fra1 for student Piotr Koska"
  ip_range    = "10.113.113.0/24"
}

# Maszyna wirtualna
resource "digitalocean_droplet" "student_droplet" {
  name = "stf-pio-kos-development-fra1-droplet"
  region = "fra1"
  size = "s-1vcpu-1gb"
  image = "ubuntu-20-04-x64"
  tags = ["stf","piotr_koska"]

  # blok z timeouts
  timeouts {
    create = "50s" # 50 sekund dla create
    update = "100s" # 100 sekund dla update
    delete = "30s" # 30 sekund dla delete
  }
}
