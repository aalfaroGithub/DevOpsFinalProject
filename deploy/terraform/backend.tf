terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.18.0"
    }
  }

  // Adding a s3 bucket to store the terraform state file
  backend "s3" {
    bucket = "terraform-state-bucket-123456789"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}