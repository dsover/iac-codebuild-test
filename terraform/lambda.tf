resource "aws_lambda_function" "iac_code_build_test_function" {
  function_name = "${var.application}-function"
  filename      = data.archive_file.lambda_zip.output_path
  handler       = "index.handler"
  runtime       = "nodejs12.x"
  memory_size   = "128" # MB
  description   = "test function for code pipeline"
  timeout       = "5" # seconds
  publish       = true
  role             = aws_iam_role.lambda.arn
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  tags = {
    contact = "alex.sover@warnermedia.com"
    application_name = var.application
  }
}

///////////////////// LAMBDA IAM:

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    sid     = "IacCodeBuildLambdaTrustPolicy"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda" {
  statement {
    sid    = "HelloWorldLambdaPolicy"
    effect = "Allow"
    actions = [
      "logs:PutLogEvents",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
    ]
    resources = ["arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:*"]
  }
}

resource "aws_iam_role" "lambda" {
  name               = "${var.application}-main-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource "aws_iam_policy" "lambda" {
  name   = "${var.application}-cloudwatch-policy"
  policy = data.aws_iam_policy_document.lambda.json
}

resource "aws_iam_role_policy_attachment" "lambda" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda.arn
}
