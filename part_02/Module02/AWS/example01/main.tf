# VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
        Name = "szkolenia.cloud"
    }
}

# Subnet
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-central-1a"

    tags = {
            Name = "szkolenia.cloud"
        }
}

# Security Group
resource "aws_security_group" "ssh_security_group" {
  name        = "ssh_access"
  description =        "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     =       22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   =      0
    to_port      = 0
    protocol     = "-1"
    cidr_blocks        = ["0.0.0.0/0"]
  }
}

# Tworzenie bramy internetowej
resource "aws_internet_gateway" "example_igw" {
  vpc_id =      aws_vpc.vpc.id

  tags = {
       Name =    "example-igw"
  }
}

# Tworzenie trasy dla ruchu internetowego
resource "aws_route_table" "example_route_table" {
  vpc_id =      aws_vpc.vpc.id

  route {
        cidr_block = "0.0.0.0/0"
         gateway_id = aws_internet_gateway.example_igw.id
  }

  tags = {
    Name = "example-route-table"
  }
}

# Przypisanie trasy do podsieci
resource "aws_route_table_association" "example_rta" {
        subnet_id      = aws_subnet.subnet.id
         route_table_id = aws_route_table.example_route_table.id
}

# Ec2

resource "aws_instance" "example" {
  ami = "ami-0669b163befffbdfc"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet.id
  vpc_security_group_ids = [aws_security_group.ssh_security_group.id]

    tags = {
        Name = "example-instance"
    }
}

