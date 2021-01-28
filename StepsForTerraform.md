
# Things needed for building

## project setup
- top level
    - sourcecode (how ever the project works)
    - terraform for souce infrastructure
    - `buildspec.yml` file for build
    - build directory with build scripts and infrastructure for `codeBuild/codePipeline`
        - terraform scripty scripts
        - use npm terraform package `@jahed/terraform` for tf installation
        - terraform for `codeBuild/codePipeline` including roles for deployment of aws infrastructure
        - include cross account permission for S3 state bucket
    

>role for lambda terraform
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "arn:aws:iam::421654392560:role/iac-*",
            "Condition": {
                "StringEquals": {
                    "iam:PassedToService": "lambda.amazonaws.com"
                },
                "StringLike": {
                    "aws:PrincipalArn": "arn:aws:iam::421654392560:role/service-role/alex-build-test-role-3",
                    "iam:AssociatedResourceARN": "arn:aws:lambda:*:421654392560:function:iac-*"
                }
            }
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "lambda:*"
            ],
            "Resource": "arn:aws:lambda:*:421654392560:function:iac-*",
            "Condition": {
                "StringLike": {
                    "aws:PrincipalArn": "arn:aws:iam::421654392560:role/service-role/alex-build-test-role-3"
                }
            }
        }
    ]
}
```