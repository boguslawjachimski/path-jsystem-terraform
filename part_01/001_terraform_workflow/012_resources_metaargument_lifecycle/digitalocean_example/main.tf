# Projekt
resource "digitalocean_project" "student_projekt" {
  name        = "stf-pio-kos-development" # zmienimy nazwe
  description = "Project for student Piotr Koska"
  purpose     = "Project for learning Terraform"
  environment = "development"
}

# VPC
resource "digitalocean_vpc" "student_network" {
  name        = "stf-pio-kos-development-fra1-net"
  region      = "fra1"
  description = "VPC for region fra1 for student Piotr Koska"
  ip_range    = "10.10.113.0/24"
}

# Maszyna wirtualna
resource "digitalocean_droplet" "student_droplet" {
  count = 2
  name = "stf-pio-kos-development-fra1-droplet-${count.index}"
  region = "fra1"
  size = "s-2vcpu-2gb"
  image = "ubuntu-20-04-x64" # maipulujemy tym parametrem w celu podmiany zasobu
  vpc_uuid = digitalocean_vpc.student_network.id
  tags = ["stf","piotr_koska"] # dodamy tag po stronie GUI
  ssh_keys = [digitalocean_ssh_key.student_ssh_key.id]

  timeouts {
    create = "200s"
    update = "200s"
    delete = "200s"
  }

  lifecycle {
    create_before_destroy = true
    #prevent_destroy = false
    #ignore_changes = [ "tags","name" ]
    #replace_triggered_by = [ digitalocean_project.student_projekt ]
    #prevent_destroy = true
  }
}
