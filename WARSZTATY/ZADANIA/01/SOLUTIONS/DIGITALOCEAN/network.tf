resource "digitalocean_vpc" "name" {
    name = "tf-piotrkoska-vpc-temp"
    region = "fra1"
    ip_range = "10.113.113.0/24"
}

resource "digitalocean_firewall" "name" {
    name = "tf-example-firewall-temp"
    droplet_ids = [digitalocean_droplet.main.id]

    inbound_rule {
        protocol = "tcp"
        port_range = "22"
        source_addresses = ["0.0.0.0/0"]
    }

    outbound_rule {
        protocol = "tcp"
        port_range = "1-65535"
        destination_addresses = ["0.0.0.0/0"]
    }

    outbound_rule {
        protocol = "udp"
        port_range = "1-65535"
        destination_addresses = ["0.0.0.0/0"]
    }
}