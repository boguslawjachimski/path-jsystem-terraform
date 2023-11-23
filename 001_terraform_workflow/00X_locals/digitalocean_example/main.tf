# Main configuration file for Terraform

# This is directive for local variables
locals {
  username_tag = "${var.name}-${var.surname}"
  prefix       = "${var.prefix}-${local.username_tag}-${var.environment}"
  environment  = var.environment
}

# This two resources are for creating project and VPC
resource "digitalocean_project" "student_projekt" {
  name        = local.prefix
  description = "Project for student ${var.name} ${var.surname}"
  purpose     = "Project for learning Terraform"
  environment = local.environment
}

resource "digitalocean_vpc" "student_network" {
  name        = "${local.prefix}-fra1-net"
  region      = "fra1"
  description = "VPC for region fra1 for student ${var.name} ${var.surname}"
  ip_range    = "10.10.0.0/24"
}