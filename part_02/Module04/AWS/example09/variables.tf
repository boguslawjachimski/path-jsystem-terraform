variable "aws_access_key" {
  type = string
  description = "AWS Access Key"
  sensitive   = true
}

variable "aws_secret_key" {
  type = string
  description = "AWS Secret Key"
  sensitive   = true
}

variable "global_instance_type" {
  type = string
  description = "Set the instance type globally for all regions"
  default = "t2.micro"
}

variable "ec2_config" {
  description = "values for ec2 instances in different regions"
  type = map(object({
    ami = string
    instance_name = string
    enviroment = string
    region = string
  }))
  default = {
    "eu-central-1" = {
      ami = "ami-0faab6bdbac9486fb"
      instance_name = "EC2-EU-CENTRAL-1"
      enviroment = "dev"
      region = "eu-central-1"
    }
    "eu-west-1" = {
      ami = "ami-0905a3c97561e0b69"
      instance_name = "EC2-EU-WEST-1"
      enviroment = "dev"
      region = "eu-west-1"
    }
    "eu-west-2" = {
      ami = "ami-0f8f99aa5fa000138"
      instance_name = "EC2-EU-WEST-2"
      enviroment = "dev"
      region = "eu-west-2"
    }
  }
}