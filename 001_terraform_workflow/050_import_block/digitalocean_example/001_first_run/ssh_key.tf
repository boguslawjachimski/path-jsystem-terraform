resource "tls_private_key" "ssh_key" {
    algorithm = "ED25519"
}

resource "digitalocean_ssh_key" "student_ssh_key" {
  name = "stf-pio-kos-development-fra1-ssh-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

