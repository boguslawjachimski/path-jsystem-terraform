resource "digitalocean_droplet" "main" {
    image = "ubuntu-20-04-x64"
    name = var.name
    region = "nyc1"
    size = "s-1vcpu-1gb"
    vpc_uuid = var.network_id
    tags = ["main"]
}