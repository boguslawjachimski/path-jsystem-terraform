# For coection to DigitalOcean API
variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive = true
}
