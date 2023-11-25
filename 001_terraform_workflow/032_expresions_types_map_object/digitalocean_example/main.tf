locals {
  acronym = "${lower(substr(var.user_name, 0, 3))}-${lower(substr(var.user_surname, 0, 3))}"
  name = "${var.sufix}-${substr(var.user_name, 0, 3)}-${substr(var.user_surname, 0, 3)}-${var.environment}"
}

locals {
  regions = {
    nyc1 = { second_octet = var.second_octet, third_octet = 0 }
    nyc2 = { second_octet = var.second_octet, third_octet = 16 }
    nyc3 = { second_octet = var.second_octet, third_octet = 32 }
    sfo1 = { second_octet = var.second_octet, third_octet = 48 }
    sfo2 = { second_octet = var.second_octet, third_octet = 64 }
    sfo3 = { second_octet = var.second_octet, third_octet = 80 }
    tor1 = { second_octet = var.second_octet, third_octet = 96 }
    lon1 = { second_octet = var.second_octet, third_octet = 112 }
    ams2 = { second_octet = var.second_octet, third_octet = 128 }
    ams3 = { second_octet = var.second_octet, third_octet = 144 }
    fra1 = { second_octet = var.second_octet, third_octet = 160 }
    sgp1 = { second_octet = var.second_octet, third_octet = 176 }
    blr1 = { second_octet = var.second_octet, third_octet = 192 }
    syd1 = { second_octet = var.second_octet, third_octet = 208 }
  }
}

resource "digitalocean_project" "student_projekt" {
  name        = "${local.name}"
  description = "Project for student ${var.user_name} ${var.user_surname}"
  purpose     = "Project for learning Terraform"
  environment = "${var.environment}"
}

resource "digitalocean_vpc" "student_network" {
  for_each = local.regions
  name        = "${local.name}-${each.key}-vpc"
  region      = each.key
  description = "VPC for region ${each.key} for student ${var.user_name} ${var.user_surname}"
  ip_range    = "10.${each.value.second_octet}.${each.value.third_octet}.0/20"
}

# VM configuration
resource "digitalocean_droplet" "student_droplet" {
  for_each = { for droplet in var.droplet_object : droplet.name => droplet}
  name = "${local.name}-${each.key}"
  region = "${var.region}"
  size = each.value.size
  image = "ubuntu-22-04-x64"
  vpc_uuid = digitalocean_vpc.student_network[var.region].id
  tags = toset(concat(["stf","piotr_koska"], each.value.tags))
  ssh_keys = [digitalocean_ssh_key.default.id]
  user_data = file("./_files/nginx.yaml")
  
  timeouts {
    create = "200s"
    update = "200s"
    delete = "200s"
  }

  depends_on = [ digitalocean_vpc.student_network ]

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

#data "digitalocean_droplet" "student_droplet" {
#  id = digitalocean_droplet.student_droplet.id
#}
