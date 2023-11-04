# to plik z naszym kodem

resource "digitalocean_project" "student_project" {
  name = "${var.projekt_name}_${var.student}"
  description = "Project for ${var.student}"
  purpose = "Test Student Project"
  environment = "Development"
}

resource "digitalocean_vpc" "student_vpc" {
  name = "tf-${var.projekt_name}-${var.student}"
  description = "VPC for ${var.student}"
  region = "fra1"
}