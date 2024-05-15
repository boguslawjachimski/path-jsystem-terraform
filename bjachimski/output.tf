output "region_name" {
  value = digitalocean_vpc.main.region
}

output "tls_private_key" {
  value = tls_private_key.main.public_key_openssh
}

output "droplet_name" {
    value = {for d in digitalocean_droplet.main : d.name => d.name}
}

output "droplet_ip" {
    value = {for d in digitalocean_droplet.main : d.name => d.ipv4_address}
}


output "droplet_id" {
    value = {for d in digitalocean_droplet.main : d.name => d.id}
}
