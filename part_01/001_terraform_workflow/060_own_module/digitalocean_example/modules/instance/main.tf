resource "digitalocean_vpc" "main" {
  name        = "tf-main-for-${var.instance_config["name"]}-network"
  region      = var.instance_config["region"]
  description = "Terraform main network for ${var.instance_config["name"]} instance"
  ip_range    = var.vpc_network_address
}

resource "digitalocean_droplet" "instance" {
  count         = var.instance_config["count"]
  name          = var.instance_config["name"]
  region        = var.instance_config["region"]
  size          = var.instance_config["size"]
  image         = var.instance_config["image"]
  backups       = var.instance_config["backups"]
  monitoring    = var.instance_config["monitoring"]
  ssh_keys      = var.instance_ssh_keys
  tags          = var.instance_tags
  user_data     = var.instance_config["user_data"]
  droplet_agent = var.instance_config["droplet_agent"]
  vpc_uuid      = digitalocean_vpc.main.id
}

resource "digitalocean_floating_ip" "main" {
  count = var.instance_config["count"]
  region = var.instance_config["region"]
}

resource "digitalocean_floating_ip_assignment" "main" {
  count = var.instance_config["count"]
  ip_address = digitalocean_floating_ip.main[count.index].ip_address
  droplet_id = digitalocean_droplet.instance[count.index].id
}

