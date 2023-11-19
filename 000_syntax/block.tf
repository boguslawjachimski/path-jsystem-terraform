terraform { # This is a block
  required_providers { # This is a block
    digitalocean = { # This is a block
      source  = "digitalocean/digitalocean" # This is a argument
      version = "~> 2.0"
    }
  }
  required_version = ">= 0.14.0"
}

provider "digitalocean" { # This is a block
  token = var.do_token
}

resource "digitalocean_project" "student_projekt" { # This is a block
  name        = "stf-pio-kos-development"
  description = "Project for student Piotr Koska"
  purpose     = "Project for learning Terraform"
  environment = "Developlent"
}

variable "do_token" { # This is a block
  description = "DigitalOcean API token"
  type        = string
}