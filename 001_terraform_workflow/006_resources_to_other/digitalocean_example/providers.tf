provider "digitalocean" {
  alias = "do"
  token = var.do_token
}

provider "digitalocean" {
  token = var.do_token
}