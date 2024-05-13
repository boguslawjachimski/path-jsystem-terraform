resource "digitalocean_droplet" "test" {
  name     = var.vm_name_in_module
  image    = "ubuntu-20-04-x64"
  region   = var.region
  size     = var.vm_size
  vpc_uuid = digitalocean_vpc.test.id
}

resource "digitalocean_vpc" "test" {
  name     = var.network_name
  region   = var.region
  ip_range = var.ip_range
}