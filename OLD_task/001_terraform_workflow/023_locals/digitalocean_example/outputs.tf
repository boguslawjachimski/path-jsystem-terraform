output "droplet_ip" {
  value = data.digitalocean_droplet.student_droplet.*.ipv4_address
}

output "private_key" {
  value = tls_private_key.ssh_key.private_key_pem
  sensitive = true
  precondition {
    condition = tls_private_key.ssh_key.algorithm == "ED25519"
    error_message = "The algorithm must be ED25519"
  }
}