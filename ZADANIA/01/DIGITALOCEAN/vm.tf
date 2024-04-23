#<block tyupe> "<provider resoreces block name>" "<our name value - unikatowa w calym kodzie>"
resource "digitalocean_droplet" "main" { # <- unikatowy adres zasobu.
    image  = "ubuntu-20-04-x64"
    name   = "tf-piotrkoska-temp-droplet" # atrybut nazwa maszyny wirtualnej.
    region = "fra1"
    size   = "s-1vcpu-1gb"
    vpc_uuid = digitalocean_vpc.main.id
    ssh_keys = [digitalocean_ssh_key.main.id]
}

resource "digitalocean_ssh_key" "main" {
    name       = "tf-piotrkoska-temp-ssh-key"
    public_key = tls_private_key.name.public_key_openssh
}

resource "digitalocean_firewall" "main" {
  name = "tf-piotrkoska-temp-firewall"

  droplet_ids = [digitalocean_droplet.main.id] # <- odowałanie do zasobu.

    inbound_rule {
        protocol           = "tcp"
        port_range         = "22"
        source_addresses   = ["0.0.0.0/0"]
    }

    outbound_rule {
        protocol           = "tcp"
        port_range         = "1-65535"
        destination_addresses = ["0.0.0.0/0"]
    }

    outbound_rule {
        protocol           = "udp"
        port_range         = "1-65535"
        destination_addresses = ["0.0.0.0/0"]
    }
}

resource "digitalocean_project" "main" {
 name = "tf-piotrkoska-temp-project"
 resources = [ digitalocean_droplet.main.urn ]
}

resource "tls_private_key" "name" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "local_file" "key" {
    content  = tls_private_key.name.private_key_pem
    filename = "./artefakty/id_rsa"
    file_permission = 0600
}



