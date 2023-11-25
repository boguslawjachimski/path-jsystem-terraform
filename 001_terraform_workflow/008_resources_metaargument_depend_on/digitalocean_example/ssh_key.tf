# Generacja klucza prywatnego i publicznego
resource "tls_private_key" "ssh_key" {
    algorithm = "RSA"
    rsa_bits = 4096
}

# Zaleznosc zasobu digitalocean_ssh_key od zasobu tls_private_key - dodanie klucza ssh.
resource "digitalocean_ssh_key" "student_ssh_key" {
  name = "stf-pio-kos-development-fra1-ssh-key"
  public_key = tls_private_key.ssh_key.public_key_openssh

  depends_on = [ digitalocean_project.student_projekt, tls_private_key.ssh_key ]
}

