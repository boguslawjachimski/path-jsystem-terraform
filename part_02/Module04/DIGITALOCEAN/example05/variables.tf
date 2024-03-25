variable "do_token" {
  description = "value of the DigitalOcean token"
  type        = string
  sensitive = true
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
}