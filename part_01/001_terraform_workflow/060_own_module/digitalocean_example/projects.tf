resource "digitalocean_project" "main" {
  name        = "tf-main-project"
  description = "Terraform main project"
  purpose     = "test"
  environment = "development"
}