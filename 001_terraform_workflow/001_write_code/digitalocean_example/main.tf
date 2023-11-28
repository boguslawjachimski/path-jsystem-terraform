# Głowna konfiguracja Terraforma

# Projekt
resource "digitalocean_project" "student_projekt" {
  name        = "stf-pio-kos-developmentx"
  description = "Project for student Piotr Koska"
  purpose     = "Project for learning Terraform"
  environment = "development"
}

# Sieć
resource "digitalocean_vpc" "student_network" {
  name        = "stf-pio-kos-development-fra1-net"
  region      = "fra1"
  description = "VPC for region fra1 for student Piotr Koska"
  ip_range    = "10.113.113.0/24"
}