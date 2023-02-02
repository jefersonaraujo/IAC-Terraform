terraform {
  backend "s3" {
    bucket  = "iac-terraform-iac"
    key     = "prod/ecs-ec2-terraform.tfstate"
    region  = "us-west-2"
    profile = "terraform"


  }
}
