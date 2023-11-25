# Lokalny zasob terraform - klucz ssh.
resource "tls_private_key" "ssh_key" {
    algorithm = "RSA"
    rsa_bits = 4096
}

# Zdalny zasob digitalocean - dodanie klucza ssh.
resource "digitalocean_ssh_key" "student_ssh_key" {
  name = "stf-pio-kos-development-fra1-ssh-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}
