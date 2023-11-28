module "JenkinsServer" {
  source = "./modules/instance"

  region = var.region
  sshkey = tls_private_key.stf_ssh_key.public_key_openssh
}