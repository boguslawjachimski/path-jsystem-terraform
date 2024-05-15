variable "do_token" {
  type      = string
  sensitive = true
}

variable "number" {
  type    = number
  default = 2
}

variable "vpc_name" {
  type = string
  default = "bjachimski"
}

variable "region_name" {
  type = string
  default = "fra1"
}

variable "ip_range" {
  type = string
  default = "10.113.100.0/24"
}

variable "ssh_keyname" {
  type = string
  default = "bjachimski"
}

variable "firewall_name" {
  type = string
  default = "bjachimski-firewall"
}

variable "tls_private_key_type" {
  type = string
  default = "RSA"
}

variable "tls_private_key_lenght" {
  type = number
  default = 4096
}

variable "tls_private_key_local_location" {
  type = string
  default = "./key"
}

variable "tls_private_key_local_permissions" {
  type = number
  default = 0600
}
