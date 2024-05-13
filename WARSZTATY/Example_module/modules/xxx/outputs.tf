output "ip_public" {
  value = digitalocean_droplet.test.ipv4_address
}