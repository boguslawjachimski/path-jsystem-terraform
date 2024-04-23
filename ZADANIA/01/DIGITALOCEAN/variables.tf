variable "do_token" {
  description = "value of DigitalOcean API token"
  type = string
}

variable "name_ssh_key" {
  description = "name of the SSH key"
  type = string
  default = "tf-piotrkoska-temp-ssh-key"
}

variable "name_firewall" {
  description = "name of the firewall"
  type = string
}

variable "name_project" {
  description = "name of the project"
  type = string
  sensitive = true
}

variable "algorithm" {
  description = "algorithm of the private key"
  type = string
}

variable "size_vm" {
  description = "size of the VM"
  type = string
  default = "p-2vcpu-2gb"

  #validation {
  #  condition = length(var.size_vm) > 2 && substr(var.size_vm, 0, 2) == "s-"
  #  error_message = "PIOTR mowi: value of size_vm must start with 's-' example s-2vcpu-2gb"
  #}
}
