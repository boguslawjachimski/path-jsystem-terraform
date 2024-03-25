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