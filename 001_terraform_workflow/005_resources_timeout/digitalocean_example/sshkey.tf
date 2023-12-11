resource "tls_private_key" "stf_ssh_key" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "digitalocean_ssh_key" "name" {
    name = "stf_ssh_key"
    public_key = tls_private_key.stf_ssh_key.public_key_openssh
}