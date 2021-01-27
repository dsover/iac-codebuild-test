
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
    



