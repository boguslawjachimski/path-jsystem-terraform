resource "digitalocean_vpc" "main" {
  for_each = local.regions
  name =  "${local.tf}-${var.vpc_config.name}-${each.key}-${local.sufix}"
  region = "${each.key}"
  description = "${var.vpc_config.description}"
  ip_range = "${local.first_octet}.${var.vpc_config.secound_octet}.${each.value}.0/20"
}