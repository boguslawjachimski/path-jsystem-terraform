data "http" "terraform_io" {
  url = "https://www.terraform.io"

  lifecycle {
    postcondition {
        condition = self.status_code == 200
        error_message = "${self.url} returned an unhealthy status code"
    }
  }
}