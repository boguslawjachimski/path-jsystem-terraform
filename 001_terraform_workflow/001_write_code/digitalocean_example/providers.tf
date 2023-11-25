# Wszelkie konfiguracje dostawców powinny być zapisane w pliku providers.tf

# Provider alias
provider "digitalocean" {
  alias = "do"
  token = var.do_token
}

# Provider default
provider "digitalocean" {
  token = var.do_token
}