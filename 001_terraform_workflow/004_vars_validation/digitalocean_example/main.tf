# Main configuration file for Terraform

# This two resources are for creating project and VPC
resource "digitalocean_project" "student_projekt" {
  name        = "${var.prefix}-${var.name}-${var.surname}-${var.environment}"
  description = "Project for student ${var.name} ${var.surname}"
  purpose     = "Project for learning Terraform"
  environment = var.environment
}

resource "digitalocean_vpc" "student_network" {
  name        = "${var.prefix}-${var.name}-${var.surname}-${var.environment}-fra1-net"
  region      = "fra1"
  description = "VPC for region fra1 for student ${var.name} ${var.surname}"
  ip_range    = "10.10.0.0/24"
}