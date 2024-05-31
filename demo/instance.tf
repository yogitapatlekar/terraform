provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "web" {
  ami  = "ami-00beae93a2d981137"
  instance_type = "t3.micro"

  key_name = "1" 

  security_groups = ["sg-0c4bf15d5abd926d2"]

  tags = {
    Name = "HelloWorld"
  }
}