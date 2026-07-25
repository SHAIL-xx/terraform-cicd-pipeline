terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "mock_key"
  secret_key                  = "mock_secret"
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3  = "http://localhost:4566"
    sqs = "http://localhost:4566"
  }
}

# S3 Bucket for Storage
resource "aws_s3_bucket" "app_assets" {
  bucket = "cicd-app-assets-bucket"
}

# SQS Queue for Background Messages
resource "aws_sqs_queue" "job_queue" {
  name = "cicd-job-queue"
}