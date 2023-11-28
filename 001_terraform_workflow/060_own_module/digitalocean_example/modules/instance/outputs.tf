output "instances_ip" {
  value       = digitalocean_droplet.instance.*.ipv4_address
  description = "value of instances_ip"
}

output "instances_id" {
  value       = digitalocean_droplet.instance.*.id
  description = "value of instances_id"
}

output "instances_urn" {
  value       = digitalocean_droplet.instance.*.urn
  description = "value of instances_urn"
}