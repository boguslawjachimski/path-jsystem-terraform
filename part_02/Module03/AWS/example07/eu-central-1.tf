# EC2 Instance
resource "aws_instance" "ec2" {
  ami                         = "ami-0faab6bdbac9486fb" #"ami-0669b163befffbdfc"
  instance_type               = "t2.medium"
  subnet_id                   = aws_subnet.subnet.id
  vpc_security_group_ids      = [aws_security_group.sg.id]
  key_name                    = aws_key_pair.key.key_name
  associate_public_ip_address = true

  tags = {
    Name = "EC2-EU-CENTRAL-1"
    evn  = "dev"
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
    source = "./_files/index.html"
    destination = "/tmp/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "set -o errexit",
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo systemctl status nginx | grep active",
      "sudo cp -f /tmp/index.html /var/www/html/index.html"
     ]
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [ tags ]
    replace_triggered_by = [ aws_subnet.subnet ]
    #prevent_destroy = true
  }
}

resource "aws_security_group" "sg" {
  name   = "MySecurityGroup"
  vpc_id = aws_vpc.vpc.id

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

resource "aws_vpc" "vpc" {
  cidr_block           = "10.10.10.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "MyVPC"
    env  = "dev"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.10.10.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "MySubnet"
    env  = "dev"
    nowy = "tag"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_key_pair" "key" {
  key_name   = "mykey"
  public_key = tls_private_key.key.public_key_openssh
}