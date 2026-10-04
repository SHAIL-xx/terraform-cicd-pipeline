terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  
  # Prevent hanging on AWS STS/Metadata checks
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  
  # Prevent S3 DNS resolution hangs in LocalStack
  s3_use_path_style           = true
}

resource "aws_s3_bucket" "cicd_bucket" {
  bucket = "tf-cicd-bucket-dev"

  tags = {
    Name        = "CI/CD S3 Bucket"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
