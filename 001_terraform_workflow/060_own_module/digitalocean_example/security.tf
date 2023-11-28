resource "tls_private_key" "main" {
  algorithm = var.ssh["algorithm"]
}

resource "local_file" "private_key" {
  content         = tls_private_key.main.private_key_openssh
  filename        = "${path.cwd}/_files/${var.ssh["name"]}_private_ssh_key.pem"
  file_permission = 0600
}

resource "digitalocean_ssh_key" "main" {
  name       = var.ssh["name"]
  public_key = tls_private_key.main.public_key_openssh
}