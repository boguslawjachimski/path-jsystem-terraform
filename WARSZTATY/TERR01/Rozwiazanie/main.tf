# Tworzymy projekt w digitalocean - tu bedziemy alokować nasze zasoby
resource "digitalocean_project" "main" {
  name = ""
  description = "Projekt wykorzystywany w ramach warsztatow z terraform"
  purpose = "Terraform Playground"
  environment = "Development"
}

# Nasz moduł dołaczamy go do projektu
module "vpc" {
  source = "./modules/vpc"

  vpc_config = {
    name        = "warsztaty"
    description = "VPC for warsztaty"
    team_account_name = "warsztaty"
    secound_octet = "0"
  }
}

#uzywamy sieci z naszą VM module.vpc.vpc_id["fra1"]

resource "digitalocean_droplet" "student_droplet" {
  count = 2
  name = "-${count.index}"
  region = var.region
  size = var.size
  image = var.image
  vpc_uuid = module.vpc.vpc_id["fra1"]
  tags = ["stf","warsztaty"]
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