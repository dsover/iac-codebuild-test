variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "application" {
  description = "Name (e.g. project name)"
  type        = string
  default     = "iac-codebuild-test"
}

variable "aws_profile" {
  type        = string
  description = "AWS profile for the provider"
  default     = "aws-turner-playground:aws-turner-playground-devops"
}