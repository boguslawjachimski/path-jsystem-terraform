output "vpc_id" {
  value = { for region, vpc in digitalocean_vpc.main : region => vpc.id}
  description = "Map of VPC IDs"
}