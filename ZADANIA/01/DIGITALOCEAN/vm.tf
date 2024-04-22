resource "digitalocean_droplet" "main" {
    image  = "ubuntu-20-04-x64"
    name   = "tf-piotrkoska-temp-droplet"
    region = "fra1"
    size   = "s-1vcpu-1gb"
}

