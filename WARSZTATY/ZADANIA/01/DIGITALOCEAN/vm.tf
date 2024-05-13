#<block tyupe> "<provider resoreces block name>" "<our name value - unikatowa w calym kodzie>"
resource "digitalocean_droplet" "main" { # <- unikatowy adres zasobu.
    #count = 3
    for_each = jsondecode(file("./files/vms.json"))

    image  = each.value.image
    name   = "${each.value.name}-${each.value.id}-test" # atrybut nazwa maszyny wirtualnej.
    region = each.value.region
    size   = contains(local.allowed_instance_types, var.size_vm) ? var.size_vm : "s-2vcpu-2gb"
    tags = each.value.tags
    vpc_uuid = digitalocean_vpc.main.id
    ssh_keys = [digitalocean_ssh_key.main.id]

    lifecycle {
    create_before_destroy = true
    #prevent_destroy = true
    #ignore_changes = [ tags ]
    replace_triggered_by = [ local_file.key ]
    #prevent_destroy = true

    #precondition {
    #  condition = contains(local.allowed_instance_types, var.size_vm)
    #  error_message = "The instance type '${var.size_vm}' is not allowed. Please choose from ${join(", ", local.allowed_instance_types)}."
    #}

    #postcondition {
    #  condition = contains(local.allowed_instance_types, var.size_vm)
    #  error_message = "The instance type '${var.size_vm}' is not allowed. Please choose from ${join(", ", local.allowed_instance_types)}."
    #}

    #precondition {
    #  condition = digitalocean_droplet.main.ipv4_address_private == "10.250.16.1"
    #  error_message = "The private IP address is not available."
    #}

  }
}

resource "digitalocean_ssh_key" "main" {
    name       = var.name_ssh_key # TU
    public_key = tls_private_key.name.public_key_openssh
}

locals {
    xxinbound_rule = [
        {
            protocol           = "tcp"
            port_range         = "22"
            source_addresses   = ["0.0.0.0/0"]
        },
        {
            protocol           = "tcp"
            port_range         = "80"
            source_addresses   = ["0.0.0.0/0"]
        }
    ]

    outbound_rule = [
        {
            protocol           = "tcp"
            port_range         = "1-65535"
            destination_addresses = ["0.0.0.0/0"]
        },
        {
            protocol           = "udp"
            port_range         = "1-65535"
            destination_addresses = ["0.0.0.0/0"]
        }
    ]
}

resource "digitalocean_firewall" "main" {
  name = var.name_firewall # TU

  droplet_ids = local.droplet_ids # w przypadku cont flatten(digitalocean_droplet.main.*.id) # <- odowałanie do zasobu.

    dynamic "inbound_rule" {
      for_each = local.xxinbound_rule
      content {
        protocol = inbound_rule.value.protocol
        port_range = inbound_rule.value.port_range
        source_addresses = inbound_rule.value.source_addresses
      }
    }

    dynamic "outbound_rule" {
      for_each = local.outbound_rule
      content {
        protocol = outbound_rule.value.protocol
        port_range = outbound_rule.value.port_range
        destination_addresses = outbound_rule.value.destination_addresses
      }
    }
}

resource "digitalocean_project" "main" {
 name = sensitive("${var.name_project}-SUPERXXX") # TU
 resources = local.resoreces_list #flatten(digitalocean_droplet.main.*.urn)
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

#data "digitalocean_droplet" "exeternal" {
#  id = 414723878
#}

#output "my_extarnala_ip" {
#  value = data.digitalocean_droplet.exeternal.ipv4_address
#}
/* Przykład importu z czwartego dnia
import {
  to = digitalocean_droplet.one
  id = 414916713
}

import {
  to = digitalocean_droplet.two
  id = 414918519
}

resource "digitalocean_droplet" "one" {
  name = "PIOTRKOSKA-TEST-1-vm1"
  region = "fra1"
  size = "s-2vcpu-2gb"
  image = "ubuntu-20-04-x64"
  tags = ["development","kos","old","pio", "stf"]
}

resource "digitalocean_droplet" "two" {
  name = "KRI-TEST-1-vm1-psikus"
  region = "fra1"
  size = "s-2vcpu-2gb"
  image = "ubuntu-20-04-x64"
  tags = ["development","kos","old","pio", "stf"]
}
*/