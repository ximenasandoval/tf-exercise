terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.5.0"
    }
  }
}


module "vpc" {
  source  = "../modules/aws_vpc"
  region  = "us-east-1"
  name    = "main"
  project = "tf-exercise"
}

module "asg" {
  source            = "../modules/aws_asg"
  region            = "us-east-1"
  name              = "test"
  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  project           = "tf-exercise"
}
