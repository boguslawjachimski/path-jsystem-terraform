# This is the variables.tf file
# This file is used to define the variables that will be used in the Terraform configuration.

# For coection to DigitalOcean API
variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

# For creating project and VPC
variable "prefix" {
  description = "Start Prefix for all resources"
  type        = string
  default     = "stf"
}

# For creating project and VPC
variable "name" {
  description = "value for name tag"
  type        = string
  default     = "piotr"
}

# For creating project and VPC
variable "surname" {
  description = "value for surname tag"
  type        = string
  default     = "koska"
}

#
variable "environment" {
  type        = string
  description = "The environment name"
  default     = "Development"

  validation {
    condition     = contains(["Development", "Staging", "Production"], var.environment)
    error_message = "The environment must be one of: Development, Staging, Production."
  }
}
