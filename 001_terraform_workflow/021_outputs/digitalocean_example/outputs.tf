output "droplet_ip" {
  value = digitalocean_droplet.student_droplet.*.ipv4_address
}

output "private_key" {
  value = tls_private_key.ssh_key.private_key_pem
  #sensitive = true
}