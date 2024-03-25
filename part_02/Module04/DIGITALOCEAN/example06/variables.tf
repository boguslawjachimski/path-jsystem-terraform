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
  default = "10.10"

  validation {
    condition = (
      can(regex("^(10)\\.([0-9]{1,2})$", var.private_subnet_prefix)) ||
      can(regex("^(172)\\.(1[6-9]|2[0-9]|3[0-1])$", var.private_subnet_prefix)) ||
      can(regex("^(192)\\.(168)$", var.private_subnet_prefix))
    )
    error_message = "The private_subnet_prefix must be a valid private IP address prefix (e.g., '10.X', '172.16-31', '192.168')."
  }
}

# 10.10.X.0/20
variable "regions" {
  description = "value of the DigitalOcean regions"
  type = map(number)
  default = {
    "nyc1" = 0
    "nyc2" = 16
    "nyc3" = 32
    "sfo1" = 48
    "sfo2" = 64
    "sfo3" = 80
    "ams2" = 96
    "ams3" = 112
    "sgp1" = 128
    "lon1" = 144
    "fra1" = 160
    "tor1" = 176
    "blr1" = 192
    "syd1" = 208
  }

  validation {
    condition = alltrue([for value in var.regions : value >=0 && value <= 255])
    error_message = "The regions map values must be between 0 and 255."
  }
}