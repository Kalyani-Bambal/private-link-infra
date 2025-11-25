resource "aws_instance" "ec2-instance" {
  ami           = "ami-04fcc2023d6e37430"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.deployer-key.key_name


  network_interface {
    network_interface_id = aws_network_interface.ec2_eni.id
    device_index         = 0
  }

  tags = merge(local.common_tags, {
    Name = var.base_name
  })

  user_data = file("${path.module}/script.sh")

}

#create Key

resource "aws_key_pair" "deployer-key" {
  key_name   = "private-link-infra-key"
  public_key = var.public_key
}

#create vpc

resource "aws_vpc" "service-provider-vpc" {
  cidr_block = "11.0.0.0/16"

  tags = merge(local.common_tags, {
    Name = local.vpc_name
  })
}


#create internet gateway

resource "aws_internet_gateway" "service-provider-igw" {
  vpc_id = aws_vpc.service-provider-vpc.id

  tags = merge(local.common_tags, {
    Name = local.igw_name
  })
}

#create public subnet

resource "aws_subnet" "service-provider-public-subnet-1a" {
  vpc_id     = aws_vpc.service-provider-vpc.id
  cidr_block = "11.0.1.0/24"

  tags = merge(local.common_tags, {
    Name = local.public_subnet_name
  })
}

#create public route table

resource "aws_route_table" "service-provider-public-rt" {
  vpc_id = aws_vpc.service-provider-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.service-provider-igw.id
  }

  tags = merge(local.common_tags, {
    Name = local.public_rt_name
  })
}


#create private subnet

resource "aws_subnet" "sservice-provider-private-subnet-1a" {
  vpc_id     = aws_vpc.service-provider-vpc.id
  cidr_block = "11.0.3.0/24"

  tags = merge(local.common_tags, {
    Name = local.private_subnet_name
  })
}


#create private route table

resource "aws_route_table" "service-provider-private-rt" {
  vpc_id = aws_vpc.service-provider-vpc.id  

  route{
    cidr_block = "10.0.0.0/0"
    gateway_id = aws_internet_gateway.service-provider-igw.id
  }

  tags = merge(local.common_tags, {
    Name = local.private_rt_name
  })
} 

#associate route tables with subnets

resource "aws_route_table_association" "public-rt-association-1a" {
  subnet_id      = aws_subnet.service-provider-public-subnet-1a.id
  route_table_id = aws_route_table.service-provider-public-rt.id
}


resource "aws_route_table_association" "private-rt-association-1a" {
  subnet_id      = aws_subnet.sservice-provider-private-subnet-1a.id
  route_table_id = aws_route_table.service-provider-private-rt.id
}

#create network interface

resource "aws_network_interface" "ec2_eni" {
  subnet_id       = aws_subnet.service-provider-public-subnet-1a.id
  private_ips     = ["11.0.1.10"]
  security_groups = [aws_security_group.ec2_sg.id]

  tags = merge(local.common_tags, {
    Name = local.eni_name
  })
}

#create elastic ip

resource "aws_eip" "ec2_eip" {
  network_interface = aws_network_interface.ec2_eni.id
  depends_on        = [aws_internet_gateway.service-provider-igw]

  tags = merge(local.common_tags, {
    Name = local.eip_name
  })
}


#create security group

resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Security group for EC2 instance"
  vpc_id      = aws_vpc.service-provider-vpc.id

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


  tags = merge(local.common_tags, {
    Name = local.sg_name
  })
}

