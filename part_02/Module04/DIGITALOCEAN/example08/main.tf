locals {
  regions = {
    "nyc1" = 0
    "nyc2" = 16
    "nyc3" = 32
    "sfo1" = 48
    "sfo2" = 64
    "sfo3" = 80
    "ams2" = 96
    "ams3" = 112
    "sgp1" = 128
    "lon1" = 144
    "fra1" = 160
    "tor1" = 176
    "blr1" = 192
    "syd1" = 208
  }
  ip = digitalocean_droplet.droplet.ipv4_address
}

resource "digitalocean_vpc" "vpc" {
  for_each = local.regions

  name = "tf-vpc-${each.key}"
  region = each.key
  ip_range = "${var.private_subnet_prefix}.${each.value}.0/20"
  description = "VPC for ${each.key} region"
}

resource "digitalocean_droplet" "droplet" {
  name = "tf-droplet"
  image = "ubuntu-20-04-x64"
  region = digitalocean_vpc.vpc["nyc1"].region
  size = "s-1vcpu-1gb"
  vpc_uuid = digitalocean_vpc.vpc["nyc1"].id
}

output "ip" {
  value = local.ip
  sensitive = true
}

output "ip_public" {
  value = digitalocean_droplet.droplet.ipv4_address
}

resource "tls_private_key" "key" {
    algorithm = "RSA"
    rsa_bits = 4096
}

output "priv_key" {
  value = tls_private_key.key.private_key_pem
  sensitive = true
}