module "JenkinsServerInstnce" {
  source = "./modules/instance"

  # VM configuration
  instance_config = {
    count         = 1
    name          = "jenkins-server"
    region        = "fra1"
    size          = "s-2vcpu-4gb"
    image         = "ubuntu-20-04-x64"
    backups       = false
    monitoring    = true
    droplet_agent = true
    user_data     = file("${path.cwd}/_files/jenkins_server.yaml")
  }

  # SSH Connection configuration for root
  instance_ssh_keys = [digitalocean_ssh_key.main.id]

  # Tags for the VM
  instance_tags = var.tags
}