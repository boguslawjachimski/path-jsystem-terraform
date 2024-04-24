output "pubic_ip" {
  value = [ for vm in digitalocean_droplet.main : vm.ipv4_address ]
  description = "value of the public IP address"
}

output "private_key" {
  value = tls_private_key.name.private_key_pem
  sensitive = true
}