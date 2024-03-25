# EC2 Instance
resource "aws_instance" "ec2-eu-west-2" {
  provider                    = aws.eu-west-2
  ami                         = "ami-0f8f99aa5fa000138"
  instance_type               = var.global_instance_type
  subnet_id                   = aws_subnet.subnet-eu-west-2.id
  vpc_security_group_ids      = [aws_security_group.sg-eu-west-2.id]
  key_name                    = aws_key_pair.key-eu-west-2.key_name
  associate_public_ip_address = true

  tags = {
    Name = "EC2-EU-WEST-2"
    evn  = "dev"
  }

  provisioner "local-exec" {
    command = "echo 'ec2-user ${self.tags["Name"]} = ${self.public_ip}' >> ip_address.txt"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.key.private_key_pem
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "./_files/index.html"
    destination = "/tmp/index.html"
  }

  provisioner "remote-exec" {
    scripts = [ 
      "./_files/amazon_linux_nginx.sh",
      "./_files/copy_index.sh"
     ]
  }

}

resource "aws_security_group" "sg-eu-west-2" {
  provider = aws.eu-west-2
  name     = "MySecurityGroup"
  vpc_id   = aws_vpc.vpc-eu-west-2.id

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

resource "aws_vpc" "vpc-eu-west-2" {
  provider             = aws.eu-west-2
  cidr_block           = "10.10.10.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "MyVPC"
    env  = "dev"
  }
}

resource "aws_subnet" "subnet-eu-west-2" {
  provider          = aws.eu-west-2
  vpc_id            = aws_vpc.vpc-eu-west-2.id
  cidr_block        = "10.10.10.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "MySubnet"
    env  = "dev"
  }
}

resource "aws_internet_gateway" "igw-eu-west-2" {
  provider = aws.eu-west-2
  vpc_id   = aws_vpc.vpc-eu-west-2.id
}

resource "aws_route_table" "rt-eu-west-2" {
  provider = aws.eu-west-2
  vpc_id   = aws_vpc.vpc-eu-west-2.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-eu-west-2.id
  }
}

resource "aws_route_table_association" "rta-eu-west-2" {
  provider       = aws.eu-west-2
  subnet_id      = aws_subnet.subnet-eu-west-2.id
  route_table_id = aws_route_table.rt-eu-west-2.id
}

resource "aws_key_pair" "key-eu-west-2" {
  provider   = aws.eu-west-2
  key_name   = "mykey"
  public_key = tls_private_key.key.public_key_openssh
}