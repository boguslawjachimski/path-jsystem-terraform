provider "aws" {
  # This is how we access variables
  region     = var.aws_region
  access_key = var.ak
  secret_key = var.sk
}