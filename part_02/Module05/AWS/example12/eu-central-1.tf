# EC2 Instance
resource "aws_instance" "ec2" {
  ami                         = local.instances.eu-central-1.ami
  instance_type               = var.global_instance_type
  subnet_id                   = aws_subnet.subnet.id
  vpc_security_group_ids      = [aws_security_group.sg.id]
  key_name                    = aws_key_pair.key.key_name
  associate_public_ip_address = true

  user_data = file("./_files/user_data.yaml")

  tags = {
    Name = "${terraform.workspace}-${local.instances.eu-central-1.instance_name}"
    evn  = local.instances.eu-central-1.enviroment
  }

  provisioner "local-exec" {
    command = "echo 'ubuntu ${self.tags["Name"]} = ${self.public_ip}' >> ${terraform.workspace}-ip_address.txt"
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

  lifecycle {
    create_before_destroy = true
    ignore_changes = [ tags ]
    replace_triggered_by = [ aws_subnet.subnet ]
    #prevent_destroy = true
  }
}

resource "local_file" "host_eu_central_1" {
    content = yamlencode ({
      ansible_host = aws_instance.ec2.public_ip
      ansible_user = "ubuntu"
      ansible_ssh_private_key_file = "./${terraform.workspace}-key"
    })
    filename = "./inventories/${terraform.workspace}/host_vars/${local.instances.eu-central-1.instance_name}.yaml"
}

resource "aws_security_group" "sg" {
  name   = "${terraform.workspace}-MySecurityGroup"
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
    Name = "${terraform.workspace}-MyVPC"
    env  = "${terraform.workspace}"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.10.10.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "${terraform.workspace}-MySubnet"
    env  = "${terraform.workspace}"
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
  key_name   = "${terraform.workspace}-key"
  public_key = tls_private_key.key.public_key_openssh
}