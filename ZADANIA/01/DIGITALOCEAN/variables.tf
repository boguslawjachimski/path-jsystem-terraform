variable "do_token" {
  description = "value of DigitalOcean API token"
  type = string
}

variable "name_ssh_key" {
  description = "name of the SSH key"
  type = string
}

variable "name_firewall" {
  description = "name of the firewall"
  type = string
}

variable "name_project" {
  description = "name of the project"
  type = string
}

variable "algorithm" {
  description = "algorithm of the private key"
  type = string
}
