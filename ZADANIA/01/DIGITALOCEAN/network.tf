resource "digitalocean_vpc" "main" {
    name = "tf-piotrkoska-temp-vpc"
    region = "fra1"
    ip_range = "10.113.113.0/24"
}