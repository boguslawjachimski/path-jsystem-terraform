# Projekt
resource "digitalocean_project" "student_projekt" {
  name        = "${var.sufix}-${var.user_name}${var.user_surname}-${var.environment}"
  description = "Project for student ${var.user_name} ${var.user_surname}"
  purpose     = "Project for learning Terraform"
  environment = "${var.environment}"
  resources = flatten(digitalocean_droplet.student_droplet.*.urn) #flatten
}

# VPC
resource "digitalocean_vpc" "student_network" {
  name        = "${var.sufix}-${var.user_name}${var.user_surname}-${var.environment}-${var.region}-vpc"
  region      = "${var.region}"
  description = "VPC for region fra1 for student Piotr Koska"
  ip_range    = "10.113.113.0/24"
}

# VM configuration
resource "digitalocean_droplet" "student_droplet" {
  count = 2
  name = "${var.sufix}-${var.user_name}${var.user_surname}-${var.environment}-${var.region}-${count.index}"
  region = "${var.region}"
  size = "s-2vcpu-2gb"
  image = "ubuntu-22-04-x64"
  vpc_uuid = digitalocean_vpc.student_network.id
  tags = ["stf","piotr_koska"]
  ssh_keys = [digitalocean_ssh_key.student_ssh_key.id]
  user_data = file("./_files/nginx.yaml")

  timeouts {
    create = "200s"
    update = "200s"
    delete = "200s"
  }

  provisioner "local-exec" {
    command = "echo ${self.ipv4_address} > ./${self.name}.txt"
  }

  provisioner "file" {
    source = "${path.cwd}/_files/index.html"
    destination = "/tmp/index.html"

    connection {
      type = "ssh"
      user = "root"
      private_key = tls_private_key.ssh_key.private_key_pem
      host = self.ipv4_address
    }
  }

  provisioner "local-exec" {
    when = destroy
    command = "rm -f ./${self.name}.txt"
    on_failure = continue
  }
}
