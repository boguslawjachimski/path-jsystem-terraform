output "droplet_ip" {
  value = data.digitalocean_droplet.inni_droplet.ipv4_address
}