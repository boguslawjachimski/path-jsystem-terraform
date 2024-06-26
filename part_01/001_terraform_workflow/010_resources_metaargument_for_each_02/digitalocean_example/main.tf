# Projekt
resource "digitalocean_project" "student_projekt" {
  name        = "stf-pio-kos-development"
  description = "Project for student Piotr Koska"
  purpose     = "Project for learning Terraform"
  environment = "development"
  #resources = flatten(digitalocean_droplet.student_droplet.*.urn) nie zadziała bo nie lista tylko mapa
  resources = [for vm in digitalocean_droplet.student_droplet : vm.urn] # trzeba w ten sposób lub recznie wpisac każdy element
}

# VPC
resource "digitalocean_vpc" "student_network" {
  name        = "stf-pio-kos-development-fra1-net"
  region      = "fra1"
  description = "VPC for region fra1 for student Piotr Koska"
  ip_range    = "10.113.113.0/24"
}

locals {
  droplets = {
    "droplet1" = sensitive({
      name   = "server1"
      region = "fra1"
      image  = "ubuntu-20-04-x64"
      size   = "s-1vcpu-1gb"
    })
    "droplet2" = sensitive({
      name   = "server2"
      region = "fra1"
      image  = "ubuntu-20-04-x64"
      size   = "s-1vcpu-1gb"
    })
    // możesz dodać więcej dropletów
  }
}

locals {
  dropletsx = {
    "droplet1" = sensitive({
      name   = "server1"
      region = "fra1"
      image  = "ubuntu-20-04-x64"
      size   = "s-1vcpu-1gb"
    })
    "droplet2" = sensitive({
      name   = "server2"
      region = "fra1"
      image  = "ubuntu-20-04-x64"
      size   = "s-1vcpu-1gb"
    })
    // możesz dodać więcej dropletów
  }
}

# VM configuration
resource "digitalocean_droplet" "student_droplet" {

  #for_each = local.droplets
  for_each = { for k in toset([for k, v in local.dropletsx : k]) : k => local.dropletsx[k] }
  name   = "${each.value.name}-${each.key}"
  region = each.value.region # w json specjalnie zly region dla jednej maszyny
  image  = each.value.image
  size   = each.value.size
  vpc_uuid = digitalocean_vpc.student_network.id
  tags = ["stf","piotr_koska"]
  ssh_keys = [digitalocean_ssh_key.student_ssh_key.id]
  
  timeouts {
    create = "100s"
    update = "100s"
    delete = "100s"
  }
}