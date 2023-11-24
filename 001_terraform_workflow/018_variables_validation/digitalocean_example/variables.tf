# This is the variables.tf file
# This file is used to define the variables that will be used in the Terraform configuration.

# For coection to DigitalOcean API
variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
}

variable "sufix" {
  description = "Sufix for all resources"
  type        = string
  default     = "stf"
}

variable "user_name" {
  description = "User name"
  type        = string
}

variable "user_surname" {
  description = "User surname"
  type        = string
}

variable "environment" {
  description = "Środwisko powinno być jednym z: development, staging, production"
  type        = string
  default     = "development"

  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Środowisko musi być jednym z: development, staging, production"
  }

}

variable "region" {
  description = "Region"
  type        = string
  default     = "fra1"
}

