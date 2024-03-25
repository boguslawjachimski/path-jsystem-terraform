provider "aws" {
  region     = var.ec2_config["eu-central-1"].region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

provider "aws" {
  alias      = "eu-west-1"
  region     = var.ec2_config["eu-west-1"].region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

provider "aws" {
  alias = "eu-west-2"
  region     = var.ec2_config["eu-west-2"].region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}