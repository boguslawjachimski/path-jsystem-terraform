# EC2 Instance
resource "aws_instance" "ec2-eu-west-1" {
  provider                    = aws.eu-west-1
  ami                         = var.ec2_config["eu-west-1"].ami
  instance_type               = var.global_instance_type
  subnet_id                   = aws_subnet.subnet-eu-west-1.id
  vpc_security_group_ids      = [aws_security_group.sg-eu-west-1.id]
  key_name                    = aws_key_pair.key-eu-west-1.key_name
  associate_public_ip_address = true

  tags = {
    Name = var.ec2_config["eu-west-1"].instance_name
    evn  = var.ec2_config["eu-west-1"].enviroment
  }

  provisioner "local-exec" {
    command = "echo 'ubuntu ${self.tags["Name"]} = ${self.public_ip}' >> ip_address.txt"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = tls_private_key.key.private_key_pem
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "./_files/index.html"
    destination = "/tmp/index.html"
  }

  provisioner "remote-exec" {
    script = "./_files/nginx_start.sh"
  }

}

resource "aws_security_group" "sg-eu-west-1" {
  provider = aws.eu-west-1
  name     = "MySecurityGroup"
  vpc_id   = aws_vpc.vpc-eu-west-1.id

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

resource "aws_vpc" "vpc-eu-west-1" {
  provider             = aws.eu-west-1
  cidr_block           = "10.10.10.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "MyVPC"
    env  = "dev"
  }
}

resource "aws_subnet" "subnet-eu-west-1" {
  provider          = aws.eu-west-1
  vpc_id            = aws_vpc.vpc-eu-west-1.id
  cidr_block        = "10.10.10.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "MySubnet"
    env  = "dev"
  }
}

resource "aws_internet_gateway" "igw-eu-west-1" {
  provider = aws.eu-west-1
  vpc_id   = aws_vpc.vpc-eu-west-1.id
}

resource "aws_route_table" "rt-eu-west-1" {
  provider = aws.eu-west-1
  vpc_id   = aws_vpc.vpc-eu-west-1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-eu-west-1.id
  }
}

resource "aws_route_table_association" "rta-eu-west-1" {
  provider       = aws.eu-west-1
  subnet_id      = aws_subnet.subnet-eu-west-1.id
  route_table_id = aws_route_table.rt-eu-west-1.id
}

resource "aws_key_pair" "key-eu-west-1" {
  provider   = aws.eu-west-1
  key_name   = "mykey"
  public_key = tls_private_key.key.public_key_openssh
}