resource "digitalocean_firewall" "management" {
  name        = "management"
  droplet_ids = module.JenkinsServerInstnce.instances_id

  dynamic "inbound_rule" {
    for_each = var.admin_allowed_ports
    content {
      protocol         = "tcp"
      port_range       = inbound_rule.value
      source_addresses = var.admin_ips
    }
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0"]
  }
}


resource "digitalocean_firewall" "internal_communication" {
  name        = "internal-communication"
  droplet_ids = module.JenkinsServerInstnce.instances_id

  inbound_rule {
    protocol           = "tcp"
    port_range         = "1-65535"
    source_droplet_ids = module.JenkinsServerInstnce.instances_id
  }

  outbound_rule {
    protocol                = "tcp"
    port_range              = "1-65535"
    destination_droplet_ids = module.JenkinsServerInstnce.instances_id
  }

  outbound_rule {
    protocol                = "udp"
    port_range              = "1-65535"
    destination_droplet_ids = module.JenkinsServerInstnce.instances_id
  }
}