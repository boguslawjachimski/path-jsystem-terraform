resource "tls_private_key" "main" {
  algorithm = var.tls_private_key_type
  rsa_bits  = var.tls_private_key_lenght
}
resource "local_file" "main" {
  content         = tls_private_key.main.private_key_openssh
  filename        = var.tls_private_key_local_location
  file_permission = var.tls_private_key_local_permissions
}

