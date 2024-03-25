variable "do_token" {
  description = "value of the DigitalOcean token"
  type        = string
  sensitive = true
}

# 10.X.X.X
# 172.16-31.X.X
# 192.168.X.X
variable "private_subnet_prefix" {
  description = "The first and second octet of a private subnet address (e.g., '10.0', '172.16', '192.168')."
  type = string

  validation {
    condition = (
      can(regex("^(10)\\.([0-9]{1,2})$", var.private_subnet_prefix)) ||
      can(regex("^(172)\\.(1[6-9]|2[0-9]|3[0-1])$", var.private_subnet_prefix)) ||
      can(regex("^(192)\\.(168)$", var.private_subnet_prefix))
    )
    error_message = "The private_subnet_prefix must be a valid private IP address prefix (e.g., '10.X', '172.16-31', '192.168')."
  }
}

