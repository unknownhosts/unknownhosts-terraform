provider "aws" {
  region  = "ap-northeast-2" # Please use the default region ID
  version = "~> 2.49.0"      # Please choose any version or delete this line if you want the latest version

  assume_role {
    role_arn     = var.assume_role_arn
    session_name = var.atlantis_user
  }
}

# S3 bucket for backend
resource "aws_s3_bucket" "terraformState" {
  bucket = "${var.environmentName}-${var.accountName}-terraformState-s3"

  versioning {
    enabled = true
  }
}

