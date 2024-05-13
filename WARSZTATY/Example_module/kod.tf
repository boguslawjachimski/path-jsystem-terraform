resource "digitalocean_droplet" "test" {
  name     = "my-droplet-1"
  image    = "ubuntu-20-04-x64"
  region   = "fra1"
  size     = "s-1vcpu-1gb"
  vpc_uuid = digitalocean_vpc.test.id
}

resource "digitalocean_vpc" "test" {
  name     = "my-vpc-pko"
  region   = "fra1"
  ip_range = "10.113.113.0/24"
}

module "MojModul" {
  source = "./modules/xxx"
  region = "fra1"
  network_name = "my-vpc-pko2"
  ip_range = "10.114.150.0/24"
  vm_name_in_module = var.vm_name
}

module "MojModul2" {
  source = "./modules/xxx"
  region = "fra1"
  network_name = "my-vpc-pko-module2"
  ip_range = "10.114.116.0/24"
  vm_name_in_module = var.vm_name
}

resource "local_file" "ip" {
  content = module.MojModul.ip_public
  filename = "ip.txt"
}