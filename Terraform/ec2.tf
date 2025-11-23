resource "aws_instance" "ec2-instance" {
  ami           = "ami-0a71e3eb8b23101ed"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.deployer-key.key_name

  tags = {
    Name = "MyEC2Instance"
  }
}

#create Key

resource "aws_key_pair" "deployer-key" {
  key_name   = "private-link-infra-key"
  public_key = file("/home/ashu/Kalyani/Git/private-link-infra/Terraform/ashu.pub")
}