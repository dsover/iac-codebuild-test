data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "../lambda/handler"
  output_path = "../lambda/dist/handler.zip"
}

data "aws_caller_identity" "current" {}