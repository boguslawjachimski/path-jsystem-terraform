# Main configuration file for Terraform

# This two resources are for creating project and VPC
# Create Project
resource "digitalocean_project" "student_projekt" {
  name        = "${var.prefix}-${var.name}-${var.surname}-${var.environment}"
  description = "Project for student ${var.name} ${var.surname}"
  purpose     = "Project for learning Terraform"
  environment = var.environment
  resources = [digitalocean_droplet.firstvm.urn]
}

# Create VPC
resource "digitalocean_vpc" "student_network" {
  name        = "${var.prefix}-${var.name}-${var.surname}-${var.environment}-fra1-net"
  region      = "fra1"
  description = "VPC for region fra1 for student ${var.name} ${var.surname}"
  ip_range    = "10.10.0.0/24"
}

resource "digitalocean_droplet" "firstvm" {
  image  = "ubuntu-20-04-x64"
  name   = "firstvm"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  vpc_uuid = digitalocean_vpc.student_network.id
  tags = [digitalocean_tag.test_tag.id]
}