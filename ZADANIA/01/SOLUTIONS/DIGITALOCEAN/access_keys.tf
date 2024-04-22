resource "tls_private_key" "main" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "digitalocean_ssh_key" "main" {
    name       = "tf-piotrkoska-temp-key"
    public_key = tls_private_key.main.public_key_openssh
}

resource "local_file" "main" {
    content  = tls_private_key.main.private_key_pem
    filename = "./artifacts/private_key.pem"
    file_permission = 0600
}