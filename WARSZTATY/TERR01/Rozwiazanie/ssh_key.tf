resource "tls_private_key" "ssh_key" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "digitalocean_ssh_key" "student_ssh_key" {
  name = var.ssh_key_name
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.ssh_key.private_key_openssh
  filename = "${path.cwd}/_files/${var.ssh_key_name}"
  file_permission = 0600
}
