resource "aws_codebuild_project" "codebuild" {
  name = local.codebuild_name
  service_role = aws_iam_role.codebuild_main_role.arn
  artifacts {
    type = "NO_ARTIFACTS"
  }
  description = "iac-codebuild test"
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

  }
  source {
    type = "GITHUB"
    git_clone_depth = 1
    insecure_ssl = false
    location = "https://github.com/dsover/iac-codebuild-test.git"
    report_build_status = true
  }
  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
    s3_logs {
      status = "DISABLED"
    }
  }
  build_timeout = 60
  queued_timeout = 480
  badge_enabled = true
}

resource "aws_codebuild_webhook" "example" {
  project_name = aws_codebuild_project.codebuild.name

  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }

    filter {
      type    = "HEAD_REF"
      pattern = "main"
    }
  }
}