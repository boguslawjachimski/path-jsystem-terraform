# Projekt
resource "digitalocean_project" "student_projekt" {
  count = var.number_of_droplets
  name        = "stf-xxxxpio-kos-development"
  description = "Project for student Piotr Koska"
  purpose     = "Project for learning Terraform"
  environment = "development"
  resources = flatten(digitalocean_droplet.student_droplet.*.urn) #flatten
}

# VPC
resource "digitalocean_vpc" "student_network" {
  name        = "stf-xzxxxpio-kos-development-fra1-net"
  region      = "fra1"
  description = "VPC for region fra1 for student Piotr Koska"
  ip_range    = "10.115.113.0/24"
}

variable "number_of_droplets" {
  description = "Podaj iloś czlowieku"
}

variable "number_of_droplets1" {
  description = "test1"
}

# Maszyna wirtualna
resource "digitalocean_droplet" "student_droplet" {
  count = var.number_of_droplets # Taki zapis spowoduje stworzenie dwoch obiektow typu digitalocean_droplet.
  name = "stf-xxxpio-kos-development-fra1-droplet"
  region = "fra1"
  size = "s-1vcpu-1gb"
  image = "ubuntu-20-04-x64"
  vpc_uuid = digitalocean_vpc.student_network.id
  tags = ["stf","piotr_koska"]
  ssh_keys = [digitalocean_ssh_key.student_ssh_key.id]

  timeouts {
    create = "50s"
    update = "100s"
    delete = "30s"
  }
}
