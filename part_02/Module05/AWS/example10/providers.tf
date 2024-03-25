provider "aws" {
  region     = local.eu-central-1.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

provider "aws" {
  alias      = "eu-west-1"
  region     = local.eu-west-1.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

provider "aws" {
  alias = "eu-west-2"
  region     = local.eu-west-2.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}