resource "aws_instance" "ec2-instance" {
  ami                    = "ami-0a71e3eb8b23101ed"
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.deployer-key.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "Infrastructure"
    Owner = "DevOps-Team"
    Email = "devops@nice.com"
  }
}

#create Key

resource "aws_key_pair" "deployer-key" {
  key_name   = "private-link-infra-key"
  public_key = file("/home/ashu/Kalyani/Git/private-link-infra/Terraform/ashu.pub")
}

#create security group

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Security group for EC2 instance"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 3306
    to_port     = 3306
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
    Name = "Infrastructure"
    Owner = "DevOps-Team"
    Email = "devops@nice.com"
  } 
}

