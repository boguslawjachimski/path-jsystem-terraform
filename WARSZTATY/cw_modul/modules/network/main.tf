resource "digitalocean_vpc" "main" {
    name = var.network_name
    region = "nyc1"
}