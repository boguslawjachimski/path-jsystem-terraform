# Projekt
resource "digitalocean_project" "student_projekt" {
  name        = "stf-ppppio-kos-development"
  description = "Project for student Piotr Koska"
  purpose     = "Project for learning Terraform"
  environment = "development"
  #resources = [digitalocean_droplet.student_droplet.urn]

  depends_on = [ digitalocean_droplet.student_droplet ]
}

# VPC
resource "digitalocean_vpc" "student_network" {
  name        = "stf-pppio-kos-development-fra1-net"
  region      = "fra1"
  description = "VPC for region fra1 for student Piotr Koska"
  ip_range    = "10.113.100.0/24"

  #depends_on = [ digitalocean_project.student_projekt ]
}

# Maszyna wirtualna
resource "digitalocean_droplet" "student_droplet" {
  name = "stf-ppppio-kos-development-fra1-droplet"
  region = "fra1"
  size = "s-1vcpu-1gb"
  image = "ubuntu-20-04-x64"
  vpc_uuid = digitalocean_vpc.student_network.id
  tags = ["stf","piotr_koska"]
  ssh_keys = [digitalocean_ssh_key.student_ssh_key.id]

  timeouts {
    create = "60s"
    update = "100s"
    delete = "60s"
  }
  
  # Dyrektywa depends_on
  #depends_on = [ digitalocean_vpc.student_network ]
}
