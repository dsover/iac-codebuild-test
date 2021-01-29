![AWS Badge](https://codebuild.us-east-1.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoielRubXZDcnFUaERiTm4yK2RVOTZ2SGNVTXNPRVdSOU1FNER5WDJza1FjRWRkY2dYTWxhZjVJc0JSR3J6ZDdDdlpBVzkrSVIyTEhlUU9jVmZkRjFHUTRrPSIsIml2UGFyYW1ldGVyU3BlYyI6ImgzNUNVVkhNVTliZEdFRGQiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=main)
 
# iac-codebuild-test
this is a test repo for working with AWS code build/deploy/pipeline automation with git as the repo

# What
the set up of this repo has the build and source separated...
```
project
│   README.md
│   .buildspec.yml # CodeBuild build plan
│
└───build
│   │   package.json # use npm terraform with scripty
│   │
│   └───application-infrastructure
│   │   |   terraform that will be built by CodeBuild on push
│   │   |   ...
│   └───application-infrastructure
|   |   |   terraform used to generate CodeBuild project
│   |   │   ...
│   └───scripts
|   |   |   set of scripts used to deploy terraform
│   |   │   ...
└───src
    │   source code for application
```


# Code Pipeline
### Github
Setup of codepipeline will require a `GITHUB` service user with a PAT for OAUTH and setting up 
repos. We will need to discuss what the best pattern for this will be to limit the scope of the user
and provide the most flexability. 

To setup the Token in AWS you can follow 
the [AWS docs](https://docs.aws.amazon.com/codebuild/latest/userguide/access-tokens.html)

### buildspec.yml
the buildspec.yml is what CodeBuild does when it runs 
see [docs](https://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html) for specifics 

### Terraform
This project has a terraform project that creates CodeBuild. Note that the role for CodeBuild will need 
to be granted to create any AWS assets your application needs. In this project we needed to grant certin 
IAM permissions and Lambda permissions. It also need to have access to the S3 backend for terraforrm. you can 
look at the [iam.tf](./build/codebuild-infrastructure/iam.tf)

### Triggers
in the [codebuild.tf](./build/codebuild-infrastructure/codebuild.tf) there is a `aws_codebuild_webhook` this 
allows you to define for which branches the CodeBuild project will trigger. 

### To be done
- create a module of this
- setup github with turnercode(currently running on my personal repo)
- utilize cnn-terraform and zion-terraform modules for repeatable things
- see if we can ignore stuff based on commit message

# Scripts and other setup
## Scripts
The scripts directory use [scripty](https://www.npmjs.com/package/scripty) this allows us bundle 
in [@jahed/terraform](https://www.npmjs.com/package/@jahed/terraform). This allows terraform installation and version 
to be controlled by yarn in the build step.
the scripts in the [scripts directory](./build/scripts) follow the same path as the defined scripts 
in the build [package.json](./build/package.json) so you can just run `yarn path:to:script`.

## S3 Backend for terraform
We will need to determine the best stratagy for where to put the S3 backend. the current thought is to create
one per account. this would be a separate step from either of the two terraform projects, but is a pre-requisite for
both of them. the proposed name for the S3 backend bucket would be `tf-state-zion-${account_name}`
