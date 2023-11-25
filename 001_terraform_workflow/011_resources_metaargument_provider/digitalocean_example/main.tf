# Projekt
resource "digitalocean_project" "student_projekt" {
  # Uzywamy innego po przez alias.
  provider = digitalocean.do
  name        = "stf-pio-kos-development"
  description = "Project for student Piotr Koska"
  purpose     = "Project for learning Terraform"
  environment = "development"
}

# VPC
resource "digitalocean_vpc" "student_network" {
  name        = "stf-pio-kos-development-fra1-net"
  region      = "fra1"
  description = "VPC for region fra1 for student Piotr Koska"
  ip_range    = "10.10.113.0/24"
}

# Maszyna wirtualna
resource "digitalocean_droplet" "student_droplet" {

  for_each = jsondecode(file("${path.cwd}/_files/vms.json"))
  
  name   = "stf-${each.value.name}-${each.key}"
  region = each.value.region
  image  = each.value.image
  size   = each.value.size
  vpc_uuid = digitalocean_vpc.student_network.id
  tags = ["stf","piotr_koska"]
  ssh_keys = [digitalocean_ssh_key.student_ssh_key.id]
  
  timeouts {
    create = "100s"
    update = "100s"
    delete = "100s"
  }

  depends_on = [ digitalocean_vpc.student_network ]
}

resource "digitalocean_droplet" "student_droplet_other_provider" {

  for_each = jsondecode(file("${path.cwd}/_files/vms.json"))
  provider = digitalocean.do
  
  name   = "stf-${each.value.name}-${each.key}"
  region = each.value.region
  image  = each.value.image
  size   = each.value.size
  vpc_uuid = digitalocean_vpc.student_network.id
  tags = ["stf","piotr_koska"]
  ssh_keys = [digitalocean_ssh_key.student_ssh_key.id]
  
  timeouts {
    create = "100s"
    update = "100s"
    delete = "100s"
  }

  depends_on = [ digitalocean_vpc.student_network ]
}
