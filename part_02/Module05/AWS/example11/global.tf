locals {
  instances = {
    eu-central-1 = {
        ami = "ami-0faab6bdbac9486fb"
        instance_name = "EC2-EU-CENTRAL-1"
        enviroment = "dev"
        region = "eu-central-1"
    }
    eu-west-1 = {
        ami = "ami-0905a3c97561e0b69"
        instance_name = "EC2-EU-WEST-1"
        enviroment = "dev"
        region = "eu-west-1"
    }
    eu-west-2 = {
        ami = "ami-0f8f99aa5fa000138"
        instance_name = "EC2-EU-WEST-2"
        enviroment = "dev"
        region = "eu-west-2"
    }
  }
}

resource "local_file" "inventory" {
  content = yamlencode({
    instances = {
        hosts = { for name, instance in local.instances : instance.instance_name => {} }
    }
  })
  filename = "./inventories/hosts.yaml"
}