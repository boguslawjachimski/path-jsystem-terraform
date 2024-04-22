resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "key" {
  content        = tls_private_key.key.private_key_pem
  filename       = "./artifacts/private_key.pem"
  file_permission = 0600
  
}
