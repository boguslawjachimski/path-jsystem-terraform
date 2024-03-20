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
  default = "Piotr"

  validation {
    condition     = length(var.user_name) > 2 && lower(var.user_name) != "piotr"
    error_message = "User Name musi mieć więcej niż 2 znaki i nie może być Piotr. Podaj swoje imię!"
  }
}

variable "user_surname" {
  description = "User surname"
  type        = string
  default = "Koska"

  validation {
    condition     = length(var.user_surname) > 2 && lower(var.user_surname) != "koska"
    error_message = "User Surname musi mieć więcej niż 2 znaki i nie może być Koska. Podaj swoje nazwisko!"
  }
}

variable "environment" {
  description = "Środwisko powinno być jednym z: development, staging, production"
  type        = string
  default     = "DEVELOPMENT"

  validation {
    condition     = contains(["development", "staging", "production"],  lower(var.environment))
    error_message = "Środowisko musi być jednym z: development, staging, production"
  }

}

variable "region" {
  description = "Region"
  type        = string
  default     = "fra1"
}

