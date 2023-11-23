# Main configuration file for Terraform

# This two resources are for creating project and VPC
resource "digitalocean_project" "student_projekt" {
  name        = "stf-pio-kos-development-xxx"
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
  count = 2
  name = "stf-pio-kos-development-fra1-droplet-${count.index}"
  region = "fra1"
  size = "s-2vcpu-2gb"
  image = "ubuntu-22-04-x64"
  vpc_uuid = digitalocean_vpc.student_network.id
  tags = ["stf","piotr_koska"]
  ssh_keys = [digitalocean_ssh_key.default.id]

  timeouts {
    create = "200s"
    update = "200s"
    delete = "200s"
  }

  depends_on = [ digitalocean_vpc.student_network ]

  lifecycle {
    create_before_destroy = true
    #prevent_destroy = false
    #ignore_changes = [ "tags","name" ]
    #replace_triggered_by = [ digitalocean_project.student_projekt ]
    #prevent_destroy = true
  }
}

