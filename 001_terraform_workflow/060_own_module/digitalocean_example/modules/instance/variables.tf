variable "instance_config" {
  type = map(any)
  default = {
    count         = 1
    name          = "default_instance"
    region        = "fra1"
    size          = "s-2vcpu-4gb"
    image         = "ubuntu-20-04-x64"
    backups       = false
    monitoring    = true
    user_data     = null
    droplet_agent = null
  }
}

variable "instance_ssh_keys" {
  type    = list(string)
  default = []
}

variable "instance_tags" {
  type    = list(string)
  default = []
}

variable "vpc_network_address" {
  type    = string
  default = "10.100.100.0/24"
}