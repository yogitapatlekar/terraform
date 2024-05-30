provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "cbz-online-terraform"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

module "new_vpc" {
  source              = "module/vpc"
  vpc_cidr            = var.vpc_cidr
  project             = var.project
  env                 = var.env
  private_subnet_cidr = var.private_subnet_cidr
  public_subnet_cidr  = var.public_subnet_cidr
}
