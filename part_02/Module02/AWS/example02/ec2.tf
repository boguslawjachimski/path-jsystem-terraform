# EC2 Instance
resource "aws_instance" "ec2" {
  ami = "ami-0669b163befffbdfc"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet.id
  vpc_security_group_ids = [ aws_security_group.sg.id]
  key_name = aws_key_pair.key.key_name
  associate_public_ip_address = true

  tags = {
    Name = "MyEC2Instance"
    evn = "dev"
  }
}

resource "aws_security_group" "sg" {
  name = "MySecurityGroup"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}