# This is the variables.tf file
# This file is used to define the variables that will be used in the Terraform configuration.

# For coection to DigitalOcean API
variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive = true
}