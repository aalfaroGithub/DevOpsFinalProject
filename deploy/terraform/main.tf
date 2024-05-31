provider "aws" {
  region = var.region
  default_tags {
    tags = {
      "Project" = "DevOps-Todo-List"
    }
  }
}

module "vpc" {
  source = "./modules/VPC"
}

module "iam" {
  source = "./modules/IAM"
}

module "EC2Instance" {
  source             = "./modules/EC2"
  environment        = var.environment
  key_name           = "key_pair"
  public_subnet_id   = module.vpc.public_subnet_id
  private_subnet_id  = module.vpc.private_subnet_id
  app_security_group = module.vpc.app_security_group
  availability_zone  = "us-west-2a"
  instance_profile   = module.iam.instance_profile

}