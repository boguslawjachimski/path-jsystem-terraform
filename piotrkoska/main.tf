resource "digitalocean_project" "main" {
  name = "piotrkoskaXXX"
}

resource "digitalocean_project" "additional" {
  name = "piotrkoskaxXXX"
}

resource "digitalocean_vpc" "main" {
  name = "piotrkoskaXXX"
  region = "fra1"
  ip_range = "10.113.254.0/24"
}

output "project_id" {
  value = digitalocean_project.main.id
}
resource "digitalocean_droplet" "main" {
  name = "piotrkoska-prod-02"
  image = "ubuntu-22-04-x64"
  region = "fra1"
  size = "s-1vcpu-1gb"
  vpc_uuid = digitalocean_vpc.main.id
}