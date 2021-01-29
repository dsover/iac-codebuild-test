resource "aws_iam_role" "codebuild_main_role" {
  name = "${local.namespace}-build-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      identifiers = ["codebuild.amazonaws.com"]
      type = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}


# Policies specific for codebuild to work
data "aws_iam_policy_document" "code_build_role"{
  statement {
    effect = "Allow"
    resources = [
      "arn:aws:logs:us-east-1:${local.account_id}:log-group:/aws/codebuild/${local.codebuild_name}",
      "arn:aws:logs:us-east-1:${local.account_id}:log-group:/aws/codebuild/${local.codebuild_name}:*"
    ]
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
  }
  statement {
    effect = "Allow"
    resources = ["arn:aws:codebuild:us-east-1:${local.account_id}:report-group/${local.codebuild_name}*"]
    actions = [
      "codebuild:CreateReportGroup",
      "codebuild:CreateReport",
      "codebuild:UpdateReport",
      "codebuild:BatchPutTestCases",
      "codebuild:BatchPutCodeCoverages"
    ]

  }
}
resource "aws_iam_role_policy" "code_build_role" {
  policy = data.aws_iam_policy_document.code_build_role.json
  role = aws_iam_role.codebuild_main_role.id
}
# General IAM policies for terraform to deploy
data "aws_iam_policy_document" "iam_resource_creation_policy" {
  statement {
    effect = "Allow"
    actions = [
      "iam:UpdateAssumeRolePolicy",
      "iam:GetPolicyVersion",
      "iam:ListRoleTags",
      "iam:UntagRole",
      "iam:PutRolePermissionsBoundary",
      "iam:TagRole",
      "iam:DeletePolicy",
      "iam:CreateRole",
      "iam:AttachRolePolicy",
      "iam:PutRolePolicy",
      "iam:DeleteRolePermissionsBoundary",
      "iam:ListInstanceProfilesForRole",
      "iam:DetachRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:ListAttachedRolePolicies",
      "iam:ListRolePolicies",
      "iam:CreatePolicyVersion",
      "iam:GetRole",
      "iam:GetPolicy",
      "iam:DeleteRole",
      "iam:UpdateRoleDescription",
      "iam:CreatePolicy",
      "iam:ListPolicyVersions",
      "iam:UpdateRole",
      "iam:GetRolePolicy",
      "iam:DeletePolicyVersion",
      "iam:SetDefaultPolicyVersion"
    ]
    resources = [
      "arn:aws:iam::${local.account_id}:role/${var.application}*",
      "arn:aws:iam::${local.account_id}:policy/${var.application}*"
    ]
  }
}
resource "aws_iam_role_policy" "iam_resource_creation_policy" {
  policy = data.aws_iam_policy_document.iam_resource_creation_policy.json
  role = aws_iam_role.codebuild_main_role.id
}
# lambda policies for terraform to deploy
data "aws_iam_policy_document" "infrastructure_resource_creation_policy" {
  statement {
    effect = "Allow"
    actions = ["lambda:*"]
    resources = ["arn:aws:lambda:*:${local.account_id}:function:${var.application}*"]
  }
}
resource "aws_iam_role_policy" "infrastructure_resource_creation_policy" {
  policy = data.aws_iam_policy_document.infrastructure_resource_creation_policy.json
  role = aws_iam_role.codebuild_main_role.id
}
data "aws_iam_policy_document" "iam_pass_role_policy"{
  statement {
    effect = "Allow"
    actions = ["iam:PassRole"]
    resources = ["arn:aws:iam::${local.account_id}:role/${local.namespace}-build-role"]
    condition {
      test = "StringEquals"
      values = ["lambda.amazonaws.com"]
      variable = "iam:PassedToService"
    }
    condition {
      test = "StringLike"
      values = ["arn:aws:iam::${local.account_id}:role/service-role/${local.namespace}-build-role"]
      variable = "aws:PrincipalArn"
    }
  }
}
resource "aws_iam_role_policy" "iam_pass_role_policy" {
  policy = data.aws_iam_policy_document.iam_pass_role_policy.json
  role = aws_iam_role.codebuild_main_role.id
}
# s3 policy for terraform backend
data "aws_iam_policy_document" "read_write_tf_s3_backend" {
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:ListBucketVersions",
      "s3:ListBucket",
      "s3:GetBucketVersioning",
      "s3:GetObjectVersion"
    ]
    resources = [
      "arn:aws:s3:::tf-state-zion-${local.account_name}/*",
      "arn:aws:s3:::tf-state-zion-${local.account_name}"
    ]
  }
}
resource "aws_iam_role_policy" "read_write_tf_s3_backend" {
  policy = data.aws_iam_policy_document.read_write_tf_s3_backend.json
  role = aws_iam_role.codebuild_main_role.id
}