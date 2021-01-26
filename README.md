![AWS Badge](https://codebuild.us-east-1.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiTXlwcVNXOFk4ZTlxMEQ0V2xtZ1cwWVlGRDRWNTNqa3ZORWVpdm5wUEpOQkxXYmJJUGhmN0cyQ3FCd1YwV2YweTNHM00vdklzdUNnSWExZm9EZmoyODljPSIsIml2UGFyYW1ldGVyU3BlYyI6Ilh4WGRGeE13MUJubTJDQWoiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=main)
 
# iac-codebuild-test
this is a test repo for working with AWS code build/deploy/pipeline automation with git as the repo

# What
-- Content Manger (K8S)
-- Snowplow (Fargate kinesis s3)
-- Skit (S3 firehose)
-- Keymaker (lambda)
-- Id Bridge (lambda kinesis apigateway)

- Lambdas
- ECR (fargate)

Terraform (deploy)
    -
- 

# Code Pipeline
- Service Role 
- S3 location for Artifacts
    - KMS key for Artifacts
- Connect to github: this requires a github admin to setup but could be done across the board... (maybe)
    - set the repo
    - set the branch
    
- Setup the CodeBuild
    - Can use a custom Docker image for builds
    - Operating system (used Amazon linux)
    - the build spec:
    >By default, CodeBuild looks for a file named buildspec.yml in the source code root directory. If your buildspec file uses a different name or location, enter its path from the source root here (for example, buildspec-two.yml or configuration/buildspec.yml).
    - can log to cloudwatch and/or S3
    
- Environment Variables, it looks like we can add at both the code build and the code pipeline level

- Can do single builds, or batch builds

-Deploy stage... this is going to take some thought... it looks like we have a variety of ways to do this... 