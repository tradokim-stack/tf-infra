resource "aws_eip" "public_app" {
  domain = "vpc"
}

# resource "aws_key_pair" "main" {
#   key_name   = "my-key"
#   public_key = file("~/.ssh/id_rsa.pub")
# }

resource "aws_security_group" "main_ssh_sg" {
  name   = "main_ssh_sg"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "SSH"

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

  tags = {
    Name = "main_ssh_sg"
  }
}

resource "aws_security_group" "web_sg" {
  name   = "web_sg"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "HTTP"

    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPs"

    from_port   = 443
    to_port     = 443
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web_sg"
  }
}

resource "aws_instance" "public_app" {
#   ami           = "ami-06067086cf86c58e6" // aws linux: ec2-user
  # ami           = "ami-0b6d9d3d33ba97d99" // ubuntu: ubuntu, region: us-east-1, 22/05/2024
  ami          = "ami-0532913178263be11" // ubuntu: ubuntu, region: ap-southeast-1, 22/05/2024
  instance_type = "t3.micro"

  key_name = "keypair-southeast"

  root_block_device {
    volume_size = 10
    volume_type = "gp3" 
  }

  subnet_id              = aws_subnet.public_a.id
  vpc_security_group_ids = [ aws_security_group.main_ssh_sg.id, aws_security_group.web_sg.id ]

  associate_public_ip_address = false

  tags = {
    Name = "app-server"
  }
}

resource "aws_eip_association" "public_app" {
  instance_id   = aws_instance.public_app.id
  allocation_id = aws_eip.public_app.id
}

