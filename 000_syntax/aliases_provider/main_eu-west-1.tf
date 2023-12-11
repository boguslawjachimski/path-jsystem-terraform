# Tworzenie nowej VPC
resource "aws_vpc" "example_vpc1" {
  provider = aws.eu-west-1
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "example-vpc"
  }
}

# Tworzenie podsieci w VPC
resource "aws_subnet" "example_subnet1" {
  provider = aws.eu-west-1
  vpc_id            = aws_vpc.example_vpc1.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "example-subnet"
  }
}

# Tworzenie grupy bezpieczeństwa dla SSH
resource "aws_security_group" "ssh_security_group1" {
  provider = aws.eu-west-1
  name        = "ssh_access"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.example_vpc1.id

  ingress {
    from_port   = 22
    to_port     = 22
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

# Tworzenie bramy internetowej
resource "aws_internet_gateway" "example_igw1" {
  provider = aws.eu-west-1
  vpc_id = aws_vpc.example_vpc1.id

  tags = {
    Name = "example-igw"
  }
}

# Tworzenie trasy dla ruchu internetowego
resource "aws_route_table" "example_route_table1" {
  provider = aws.eu-west-1
  vpc_id = aws_vpc.example_vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example_igw1.id
  }

  tags = {
    Name = "example-route-table"
  }
}

# Przypisanie trasy do podsieci
resource "aws_route_table_association" "example_rta1" {
  provider = aws.eu-west-1
  subnet_id      = aws_subnet.example_subnet1.id
  route_table_id = aws_route_table.example_route_table1.id
}

# Definicja instancji EC2
resource "aws_instance" "example_instance1" {
  provider = aws.eu-west-1
  ami             = "ami-07355fe79b493752d" # Przykładowy AMI, należy zaktualizować
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.example_subnet1.id
  vpc_security_group_ids = [aws_security_group.ssh_security_group1.id]

  tags = {
    Name = "example-instance-test"
  }
}