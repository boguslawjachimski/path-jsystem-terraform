locals {
  allowed_instance_types = [
    "s-1vcpu-1gb",
    "s-1vcpu-2gb",
    "s-2vcpu-2gb",
    "s-4vcpu-4gb",
    "s-2vcpu-4gb"
  ]
  test1 = "test1"
}

locals {
  test3 = "test3"
  droplet_ids = [ for vm in digitalocean_droplet.main : vm.id ]
  resoreces_list = [ for vm in digitalocean_droplet.main : vm.urn ]
}