# Main configuration file for Terraform

# This two resources are for creating project and VPC
resource "digitalocean_project" "student_projekt" {
  name        = "stf-pio-kos-development"
  description = "Project for student Piotr Koska"
  purpose     = "Project for learning Terraform"
  environment = "development"
}

resource "digitalocean_vpc" "student_network" {
  name        = "stf-pio-kos-development-fra1-net"
  region      = "fra1"
  description = "VPC for region fra1 for student Piotr Koska"
  ip_range    = "10.10.113.0/24"
}

# VM configuration
resource "digitalocean_droplet" "student_droplet" {
  name = "stf-pio-kos-development-fra1-droplet"
  region = "fra1"
  size = "s-1vcpu-1gb"
  image = "ubuntu-20-04-x64"
  vpc_uuid = digitalocean_vpc.student_network.id
  tags = ["stf","piotr_koska"]
  ssh_keys = [digitalocean_ssh_key.default.id]

  timeouts {
    create = "50s"
    update = "100s"
    delete = "30s"
  }

  depends_on = [ digitalocean_vpc.student_network ]
}

