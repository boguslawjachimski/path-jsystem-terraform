resource "digitalocean_droplet" "test" {
  name = "test"
  size = "s-1vcpu-1gb"
    image = "ubuntu-20-04-x64"
    region = "fra1"
}