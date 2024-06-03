provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "yogita1234"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow SSH for all network"
  vpc_id      = "vpc-0e3f914a30b59bed7" # VPC ID should be a string

  ingress {
    description = "SSH rule"
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
    Name = "allow_tls"
    Env  = "Dev"
  }
}