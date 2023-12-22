variable "do_token" {
  description = "DigitalOcean API token"
  sensitive   = true
  type        = string
}

variable "ssh_key_name" {
  description = "value of the ssh key name"
  type        = string
}

variable "image" {
  description = "value of the image"
  type        = string
  default = "ubuntu-22-04-x64"
}

variable "size" {
  description = "value of the size"
  type        = string
  default = "s-1vcpu-1gb"
}

variable "vm_name" {
  description = "value of the vm name"
  type        = string
}

variable "region" {
  description = "value of the region"
  type        = string
  default = "fra1"
}