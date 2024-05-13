variable "vm_name_in_module" {
  type = string
  description = "value of the DigitalOcean API token"
}

variable "vm_size" {
  type = string
  description = "value of size"
  default = "s-1vcpu-1gb"
}

variable "region" {
  type = string
  description = "value of region"
}

variable "network_name" {
  type = string
    description = "value of network"
}

variable "ip_range" {
  type = string
    description = "value of ip range"
}