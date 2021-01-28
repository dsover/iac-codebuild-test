locals {
  namespace = replace(terraform.workspace,":" ,"-" )
  account_id = data.aws_caller_identity.current.account_id
  account_name = data.aws_iam_account_alias.current.account_alias
  codebuild_name = "${replace(terraform.workspace,":" ,"-" )}-build"
}

data "aws_caller_identity" "current" {}
data "aws_iam_account_alias" "current" {}