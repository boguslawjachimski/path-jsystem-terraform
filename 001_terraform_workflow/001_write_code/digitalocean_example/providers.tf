# Wszelkie konfiguracje dostawców powinny być zapisane w pliku providers.tf

# Provider default
provider "digitalocean" {
  token = var.do_token
}