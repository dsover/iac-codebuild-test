terraform {
  required_version = "~> 0.13.0"
  backend "s3" {
    region         = "us-east-1"
    bucket         = "tf-state-zion-playground"
    key            = "terraform.tfstate"
  }
}
provider "aws" {
  region  = var.region
  profile = var.aws_profile
}