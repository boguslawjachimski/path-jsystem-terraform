resource "tls_private_key" "stf_ssh_key" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "local_file" "private_key" {
  content  = tls_private_key.stf_ssh_key.public_key_openssh
  filename = "${path.cwd}/_files/stf_private_ssh_key.pem"
  file_permission = 0600
}