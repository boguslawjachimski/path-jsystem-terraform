# VPC
resource "digitalocean_vpc" "main" {
  name     = "bjachimski"
  region   = "fra1"
  ip_range = "10.113.100.0/24"
}

# Virtual machine
resource "digitalocean_droplet" "main" {
  name     = "bjachimski-zad01"
  image    = "ubuntu-20-04-x64"
  region   = "fra1"
  size     = "s-1vcpu-1gb"
  vpc_uuid = digitalocean_vpc.main.id
  ssh_keys = [digitalocean_ssh_key.name.id]
}

resource "digitalocean_ssh_key" "name" {
  name       = "bjachimski"
  public_key = tls_private_key.main.public_key_openssh
}

# Firewall
resource "digitalocean_firewall" "name" {
  name = "bjachimski-firewall"

  droplet_ids = [digitalocean_droplet.main.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0"]
  }
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0"]
  }
}