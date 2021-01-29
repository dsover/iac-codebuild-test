data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "../../src/lambda/handler"
  output_path = "../../src/lambda/dist/handler.zip"
}

data "aws_caller_identity" "current" {}