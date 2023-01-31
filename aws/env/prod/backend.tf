terraform {
  backend "s3" {
    bucket  = "iac-terraform-iac"
    key     = "prod/ecs-terraform.tfstate"
    region  = "us-west-2"
    profile = "aws"


  }
}
