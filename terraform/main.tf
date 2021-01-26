terraform {
  required_version = ">= 0.13.0"
  backend "s3" {
    profile        = "mss-cloud-news:aws-mss-cloud-news-devops"
    region         = "us-east-1"
    bucket         = "tf-state-cnn-zion-base"
    dynamodb_table = "tf-state-cnn-zion-base-lock-dynamo"
    key            = "terraform.tfstate"
  }
}
provider "aws" {
  region  = var.region
  profile = var.aws_profile
}