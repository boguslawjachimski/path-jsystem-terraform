resource "digitalocean_vpc" "main" {
    name = "main-root"
    region = "nyc1"
}

module "siec" {
  source = "./modules/network"
  network_name = "main-module"
}

resource "local_file" "main" {
  content = module.siec.ip_range
  filename = "./ip_range.txt"
}

locals {
  vm_name = { "vm1" = {
    name = "test"
  },
  "vm2" = {
    name = "test2"
  }}
}

module "vm" {
  for_each = local.vm_name
  source = "./modules/instances"
  network_id = module.siec.network_id
  name = each.value.name
}

module "service-account" {
  source  = "lacework/service-account/gcp"
  version = "2.0.2"
}

