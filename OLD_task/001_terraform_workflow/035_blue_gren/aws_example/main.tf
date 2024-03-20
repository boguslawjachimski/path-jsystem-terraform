provider "aws" {
  region     = "eu-central-1"
  access_key = var.ak
  secret_key = var.sk
}

data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = "main-vpc"
  cidr = var.vpc_cidr_block

  azs             = data.aws_availability_zones.available.names
  private_subnets = slice(var.private_subnet_cidr_blocks, 0, var.private_subnet_count)
  public_subnets  = slice(var.public_subnet_cidr_blocks, 0, var.public_subnet_count)

  enable_nat_gateway = true
  enable_vpn_gateway = var.enable_vpn_gateway
}

module "app_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/web"
  version = "4.17.1"

  name        = "web-sg"
  description = "Security group for web-servers with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
}

module "lb_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/web"
  version = "4.17.1"

  name        = "lb-sg"
  description = "Security group for load balancer with HTTP ports open to world"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "random_pet" "app" {
  length    = 2
  separator = "-"
}

resource "aws_lb" "app" {
  name               = "main-app-${random_pet.app.id}-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets
  security_groups    = [module.lb_security_group.security_group_id]
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }
}

resource "tls_private_key" "stf_ssh_key" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "aws_key_pair" "deployer" {
    key_name   = "deployer-key"
    public_key = tls_private_key.stf_ssh_key.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.stf_ssh_key.private_key_openssh
  filename = "${path.cwd}/_files/stf_private_ssh_key"
  file_permission = 0600
}

# Tworzenie grupy bezpieczeństwa dla SSH
resource "aws_security_group" "ssh_security_group" {
  name        = "ssh_access"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
