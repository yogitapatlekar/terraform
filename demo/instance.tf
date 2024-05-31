provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "aws_instance" {
  ami  = "ami-0fe630eb857a6ec83 "
  instance_type = "t2.micro"
  key_name = "1" 
  security_groups = ["sg-0c4bf15d5abd926d2"]
}