# Tworzenie nowej VPC
resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "example-vpc"
  }
}

# Tworzenie podsieci w VPC
resource "aws_subnet" "example_subnet" {
  vpc_id            = aws_vpc.example_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "example-subnet"
  }
}

# Tworzenie grupy bezpieczeństwa dla SSH
resource "aws_security_group" "ssh_security_group" {
  name        = "ssh_access"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.example_vpc.id

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

# Tworzenie bramy internetowej
resource "aws_internet_gateway" "example_igw" {
  vpc_id = aws_vpc.example_vpc.id

  tags = {
    Name = "example-igw"
  }
}

# Tworzenie trasy dla ruchu internetowego
resource "aws_route_table" "example_route_table" {
  vpc_id = aws_vpc.example_vpc.id

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
  subnet_id      = aws_subnet.example_subnet.id
  route_table_id = aws_route_table.example_route_table.id
}

# Definicja instancji EC2
resource "aws_instance" "example_instance" {
  ami             = "ami-0669b163befffbdfc" # Przykładowy AMI, należy zaktualizować
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.example_subnet.id
  vpc_security_group_ids = [aws_security_group.ssh_security_group.id]
  key_name      = aws_key_pair.deployer.key_name
  associate_public_ip_address = true

  tags = {
    Name = "example-instance"
  }

  # blok z timeouts
  timeouts {
    create = "50s" # 50 sekund dla create
    update = "100s" # 100 sekund dla update
    delete = "200s" # 30 sekund dla delete
  }

  lifecycle {
    create_before_destroy = true
    #prevent_destroy = false
    #ignore_changes = [ "tags","name" ]
    #replace_triggered_by = [ digitalocean_project.student_projekt ]
    #prevent_destroy = true
  }

    provisioner "local-exec" {
    command = "echo ${self.public_ip } > ./${self.tags.Name}.txt"
  }

  provisioner "local-exec" {
    command = "exit 2"
    on_failure = continue
  }

  provisioner "local-exec" {
    when = destroy
    command = "rm -f ./${self.tags.Name}.txt"
    on_failure = continue
  }
}