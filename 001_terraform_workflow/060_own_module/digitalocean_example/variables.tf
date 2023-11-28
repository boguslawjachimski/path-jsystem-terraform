# For coection to DigitalOcean API
variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "ssh" {
  type = map(any)
  default = {
    name      = "ssh_key"
    algorithm = "RSA"
  }
}

variable "tags" {
  type    = list(string)
  default = ["terraform", "test", "example"]

}

variable "admin_ips" {
  type        = list(string)
  default     = ["31.179.133.30"]
  description = "List of admin IP addresses that allowed to connect to the VM"
}

variable "admin_allowed_ports" {
  type        = list(number)
  default     = [22, 8080]
  description = "List of ports that allowed to connect to the VM"

}
