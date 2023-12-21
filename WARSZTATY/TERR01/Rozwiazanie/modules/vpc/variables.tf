variable "vpc_config" {
  type = object({
    name        = string
    description = string
    team_account_name = string
    secound_octet = string
  })

  validation {
    condition     = var.vpc_config.secound_octet >= 0 && var.vpc_config.secound_octet <= 255
    error_message = "The example variable must be between 0 and 255."
  }
}

