resource "digitalocean_vpc" "vpc" {
  for_each = var.regions

  name = "tf-vpc-${each.key}"
  region = each.key
  ip_range = "${var.private_subnet_prefix}.${each.value}.0/20"
  description = "VPC for ${each.key} region"
}