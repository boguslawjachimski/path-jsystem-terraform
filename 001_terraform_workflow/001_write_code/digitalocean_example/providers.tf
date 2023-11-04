# ten plik tworzymy jako drugi, w tym przypadku mamy tylko jeden provider

provider "digitalocean" {
    alias = "do"
    token = var.do_token
}

provider "digitalocean" {
  token = var.do_token
}