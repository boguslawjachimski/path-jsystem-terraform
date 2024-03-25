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

  lifecycle {
    postcondition {
      condition = (
        can(regex("^10\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)/([0-9]|1[0-9]|2[0-9]|3[0-2])$", self.ip_range)) ||
        can(regex("^172\\.(1[6-9]|2[0-9]|3[0-1])\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)/([0-9]|1[0-9]|2[0-9]|3[0-2])$", self.ip_range)) ||
        can(regex("^192\\.168\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)/([0-9]|1[0-9]|2[0-9]|3[0-2])$", self.ip_range))
      )
      error_message = "The IP range must be a valid private IP address range (e.g., '10.X.X.X/8', '172.16-31.X.X/12', '192.168.X.X/16')."
    }
  }
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

output "vpc_address" {
  value = digitalocean_vpc.vpc["nyc1"].ip_range

  precondition {
    condition = (can(regex("^172\\.(1[6-9]|2[0-9]|3[0-1])\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)/([0-9]|1[0-9]|2[0-9]|3[0-2])$", digitalocean_vpc.vpc["nyc1"].ip_range)))
    error_message = "The IP range must be a valid private IP address range (e.g., '172.16-31.X.X/12')."
  }
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