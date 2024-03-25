output "droplet_ip" {
  value = digitalocean_droplet.student_droplet.*.ipv4_address
}

output "droplet_name" {
  value = digitalocean_droplet.student_droplet.*.name
  sensitive = true
}

output "private_key" {
  value = nonsensitive(tls_private_key.ssh_key.private_key_pem)
}