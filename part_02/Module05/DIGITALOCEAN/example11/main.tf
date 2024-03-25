locals {
  firewall_configuration = [
    {
      protocol = "tcp"
      port_range = "80"
      source_addresses = ["0.0.0.0/0"]
    },
    {
      protocol = "tcp"
      port_range = "443"
      source_addresses = ["192.168.2.4/16"]
    },
    {
      protocol = "tcp"
      port_range = "22"
      source_addresses = ["8.8.8.8/32"]
    },
    {
      protocol = "tcp"
      port_range = "8080"
      source_addresses = ["0.0.0.0/0"]
    }]
}

resource "digitalocean_firewall" "firewall" {
  name = "example-firewall"

  dynamic "inbound_rule" {
    for_each = local.firewall_configuration

    content {
      protocol = inbound_rule.value.protocol
      port_range = inbound_rule.value.port_range
      source_addresses = inbound_rule.value.source_addresses
    }
  }

  outbound_rule {
    protocol = "tcp"
    port_range = "80"
    destination_addresses = ["0.0.0.0/0"]
  }
}