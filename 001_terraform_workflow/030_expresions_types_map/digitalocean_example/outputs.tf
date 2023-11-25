output "private_key" {
  value = tls_private_key.ssh_key.private_key_pem
  sensitive = true
  precondition {
    condition = tls_private_key.ssh_key.algorithm == "ED25519"
    error_message = "The algorithm must be ED25519"
  }
}

#output "droplet_id" {
#  value = "ID MASZYNY WIRTUALNEJ to: ${data.digitalocean_droplet.student_droplet.id} - użyj tego ID w swoim DATA."
#}