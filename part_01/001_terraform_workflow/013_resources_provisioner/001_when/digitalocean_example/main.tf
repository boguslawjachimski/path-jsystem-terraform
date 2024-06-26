# Main configuration file for Terraform

# This two resources are for creating project and VPC
resource "digitalocean_project" "student_projekt" {
  name        = "stf-pioffff-kos-development-xxx"
  description = "Project for student Piotr Koska"
  purpose     = "Project for learning Terraform"
  environment = "development"
  resources = flatten(digitalocean_droplet.student_droplet.*.urn) #flatten
}

resource "digitalocean_vpc" "student_network" {
  name        = "stf-xxxpioffff-kosfffff-development-fra1-net"
  region      = "fra1"
  description = "VPC for region fra1 for student Piotr Koska"
  ip_range    = "10.115.113.0/24"
}

# VM configuration
resource "digitalocean_droplet" "student_droplet" {
  count = 2
  name = "stf-xxxpio-kos-development-fra1-droplet-${count.index}"
  region = "fra1"
  size = "s-2vcpu-2gb"
  image = "ubuntu-22-04-x64"
  vpc_uuid = digitalocean_vpc.student_network.id
  tags = ["stf","piotr_koska"]
  ssh_keys = [digitalocean_ssh_key.student_ssh_key.id]

  timeouts {
    create = "200s"
    update = "200s"
    delete = "200s"
  }

  provisioner "local-exec" {
    command = "echo ${self.ipv4_address} > ./${self.name}.txt; echo ${self.ipv4_address_private} >> ./${self.name}.txt"
  }

  provisioner "local-exec" {
    when = destroy
    command = "rm ./${self.name}-dddd.txt"
    on_failure = continue
  }
}
