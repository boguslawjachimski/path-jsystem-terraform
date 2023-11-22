provider "aws" {
  # This is how we access variables
  region     = "eu-central-1"
  access_key = var.ak
  secret_key = var.sk
}

provider "aws" {
  alias      = "eu-west-1"
  region     = "eu-west-1"
  access_key = var.ak
  secret_key = var.sk
}