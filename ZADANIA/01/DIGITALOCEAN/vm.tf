#<block tyupe> "<provider resoreces block name>" "<our name value - unikatowa w calym kodzie>"
resource "digitalocean_droplet" "main" { # <- unikatowy adres zasobu.
    #count = 3
    for_each = jsondecode(file("./files/vms.json"))

    image  = each.value.image
    name   = "${each.value.name}-${each.value.id}" # atrybut nazwa maszyny wirtualnej.
    region = each.value.region
    size   = var.size_vm
    tags = each.value.tags
    vpc_uuid = digitalocean_vpc.main.id
    ssh_keys = [digitalocean_ssh_key.main.id]

    lifecycle {
    create_before_destroy = true
    #prevent_destroy = true
    #ignore_changes = [ tags ]
    replace_triggered_by = [ local_file.key ]
    #prevent_destroy = true
  }
}

resource "digitalocean_ssh_key" "main" {
    name       = var.name_ssh_key # TU
    public_key = tls_private_key.name.public_key_openssh
}

resource "digitalocean_firewall" "main" {
  name = var.name_firewall # TU

  droplet_ids = [ for vm in digitalocean_droplet.main : vm.id ]# w przypadku cont flatten(digitalocean_droplet.main.*.id) # <- odowałanie do zasobu.

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
 name = "${var.name_project}-SUPER" # TU
 resources = [ for vm in digitalocean_droplet.main : vm.urn ] #flatten(digitalocean_droplet.main.*.urn)
}

resource "tls_private_key" "name" {
    algorithm = var.algorithm # TU
    rsa_bits = 4096
}

resource "local_file" "key" {
    content  = tls_private_key.name.private_key_pem
    filename = "./artefakty/id_rsa"
    file_permission = 0600
}
