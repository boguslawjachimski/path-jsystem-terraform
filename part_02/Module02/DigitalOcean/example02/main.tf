# 1 maszyna wirutalna
resource "digitalocean_droplet" "vm" {
    image = "ubuntu-20-04-x64"
    name = "tf-vm"
    region = "fra1"
    size = "s-1vcpu-1gb"
    vpc_uuid = digitalocean_vpc.vpc.id
    ssh_keys = [digitalocean_ssh_key.key.id]
}
# 2 siec maska /24
resource "digitalocean_vpc" "vpc" {
    name = "tf-vpc"
    region = "fra1"
    ip_range = "10.10.10.0/24"
    description = "test network"
}
# 3 firewall
resource "digitalocean_firewall" "firewall" {
    name = "tf-firewall"
    droplet_ids = [digitalocean_droplet.vm.id]
    inbound_rule {
        protocol = "tcp"
        port_range = "22"
        source_addresses = ["0.0.0.0/0"]
    }
    inbound_rule {
        protocol = "tcp"
        port_range = "80"
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
# 4 project
resource "digitalocean_project" "project" {
    name = "tf-project"
    description = "test project"
    resources = [digitalocean_droplet.vm.urn]
}

# 5 SSH key 
resource "tls_private_key" "key" {
    algorithm = "RSA"
    rsa_bits = 4096
}

# 6
resource "digitalocean_ssh_key" "key" {
    name = "tf-key"
    public_key = tls_private_key.key.public_key_openssh
}

# 7
resource "local_file" "private_key" {
    content = tls_private_key.key.private_key_pem
    filename = "./files/private_key.pem"
    file_permission = 0600
}