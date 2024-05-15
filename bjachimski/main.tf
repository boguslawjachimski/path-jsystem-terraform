# VPC
resource "digitalocean_vpc" "main" {
  #count = var.number
  name = var.vpc_name
  #name     = "bjachimski${count.index}"
  region = var.region_name
  #ip_range = "10.113.${count.index+100}.0/24"
  ip_range   = var.ip_range
  depends_on = [local_file.main, digitalocean_ssh_key.name]
}

# Virtual machine
resource "digitalocean_droplet" "main" {

  for_each = jsondecode(file("./_files/vms.json"))

  #count    = 2
  name   = "${each.value.id}-${each.value.name}"
  image  = each.value.image
  region = each.value.region
  size   = each.value.size
  #vpc_uuid = digitalocean_vpc.main[count.index].id
  vpc_uuid  = digitalocean_vpc.main.id
  ssh_keys  = [digitalocean_ssh_key.name.id]
  tags      = each.value.tags
  user_data = file("./_files/nginx.yaml")

  timeouts {
    create = "200s" # 50 sekund dla create
    update = "100s" # 100 sekund dla update
    delete = "200s" # 30 sekund dla delete
  }

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = false
    #ignore_changes = [ tags,name ]
    #replace_triggered_by = [ digitalocean_vpc.main ]
  }

  #provisioner "local-exec" {
  #  command = "echo ${self.urn} > ./${self.urn}.txt;echo ${self.urn} >> ./${self.urn}.txt"
  #}
  provisioner "file" {
    source      = "${path.cwd}/_files/index.html"
    destination = "/tmp/index.html"
  }

  connection {
    type        = "ssh"
    user        = "root"
    private_key = tls_private_key.main.private_key_openssh
    host        = self.ipv4_address
  }

}

resource "digitalocean_ssh_key" "name" {
  name       = var.ssh_keyname
  public_key = tls_private_key.main.public_key_openssh
}

# Firewall
resource "digitalocean_firewall" "name" {
  name = var.firewall_name

  #droplet_ids = flatten(digitalocean_droplet.main.*.id)
  droplet_ids = [for VM in digitalocean_droplet.main : VM.id]
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0"]
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

locals {
  ids = [
    {
      id = 418951144
    },
    {
      id = 418951145
    }
  ]
}


data "digitalocean_droplet" "piotrkoska_droplet" {
  for_each = {for i in local.ids : i.id => i}
  id = each.value.id
    #id = "418951145"
}


output "piotrkoska_droplet_ip" {
  value = { for d in data.digitalocean_droplet.piotrkoska_droplet : d.name => d.ipv4_address }
}


output "piotrkoska_droplet_id" {
  value = { for d in data.digitalocean_droplet.piotrkoska_droplet : d.name => d.id }
}
