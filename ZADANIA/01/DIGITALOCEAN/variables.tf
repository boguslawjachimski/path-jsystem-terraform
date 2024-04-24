locals {
  allowed_instance_types = [
    "s-1vcpu-1gb",
    "s-1vcpu-2gb",
    "s-2vcpu-2gb",
    "s-4vcpu-4gb",
    "s-2vcpu-4gb"
  ]
}

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
  default = "tf-piotrkoska-temp-firewall"
}

variable "name_project" {
  description = "name of the project"
  type = string
  sensitive = true
  default = "tf-piotrkoska-temp-project"
}

variable "algorithm" {
  description = "algorithm of the private key"
  type = string
  default = "RSA"
}

variable "size_vm" {
  description = "size of the VM"
  type = string
  default = "s-1vcpu-1gb"

  validation {
    condition = ((length(var.size_vm) > 2 && substr(var.size_vm, 0, 2) == "s-") && 
                contains(["s-1vcpu-1gb",
                        "s-1vcpu-2gb",
                        "s-2vcpu-2gb",
                        "s-4vcpu-4gb",
                        "s-2vcpu-4gb"], var.size_vm))
    error_message = "The instance type '${var.size_vm}' is not allowed. Please choose from ${join(", ", ["s-1vcpu-1gb",
                        "s-1vcpu-2gb",
                        "s-2vcpu-2gb",
                        "s-4vcpu-4gb",
                        "s-2vcpu-4gb"])}."
  }
}
