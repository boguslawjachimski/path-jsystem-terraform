resource "digitalocean_vpc" "main" {
  name     = "bjachimski"
  region   = "fra1"
  ip_range = "10.113.100.0/24"
}


resource "digitalocean_droplet" "main" {
  name   = "bjachimski"
  image  = "ubuntu-20-04-x86"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  #vpc_uuid = 
}
