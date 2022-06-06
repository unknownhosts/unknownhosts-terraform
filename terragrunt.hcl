## ./terragrunt.hcl
#
#remote_state {
#  backend = "s3"
#  generate = {
#    path      = "_backend.tf"
#    if_exists = "overwrite_terragrunt"
#  }
#  config = {
#    bucket = "sandbox-test-apne2-tfstate"
#    key = "${path_relative_to_include()}/terraform.tfstate"
#    region         = "ap-northeast-2"
#    encrypt        = true
#    dynamodb_table = "sandbox-test-apne2-terraform-lock-table"
#
#    profile = "deali-sandbox"
#  }
#} ##
#
## stage/terragrunt.hcl
#generate "provider" {
#  path = "_provider.tf"
#  if_exists = "overwrite_terragrunt"
#  contents = <<EOF
#provider "aws" {
#  region                   = local.region
#  shared_credentials_files = [local.cred_file]
#  profile                  = format("deali-%s", local.account)
#}
#
#terraform {
#  required_providers {
#    aws = {
#      source  = "hashicorp/aws"
#      version = ">=4.8.0"
#    }
#  }
#}
#
#EOF
#}

# ./terragrunt.hcl

remote_state {
  backend = "s3"
  generate = {
    path      = "_backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "sandbox-test-apne2-tfstate"
    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "sandbox-test-apne2-terraform-lock-table"

    role_arn = "arn:aws:iam::964225094109:role/devops-sandbox-iam-role"
  }
}


generate "provider" {
  path = "_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "ap-southeast-1"
  assume_role {
    role_arn     = "arn:aws:iam::964225094109:role/devops-sandbox-iam-role"
    session_name = "DEVOPS_SESSION"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.8.0"
    }
  }
}

EOF
}


generate "shared_config" {
  path = "_shared_config.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
// Shared Locals
locals {
  region    = var.region
  env       = terraform.workspace
  account   = var.account
  cred_file = var.cred_file
  tags = merge(
    {
      Env     = terraform.workspace,
      Managed = "Terraform"
    },
    var.tags,
  )

  name_prefix = format("%s-%s", var.account, terraform.workspace)

  // Backend S3, DynamoDB for Remote State
  backend_s3        = var.backend_s3
  backend_dynamodb  = var.backend_dynamodb
  backend_s3_region = var.backend_s3_region
  backend_role_arn  = "arn:aws:iam::964225094109:role/devops-sandbox-iam-role"
}

// Shared Variables
variable "account" {} # Required in tfvars file
variable "region" {}  # Required in tfvars file
variable "tags" { default = {} }
variable "cred_file" { default = "~/.aws/credentials" }
variable "backend_s3" { default = "sandbox-test-apne2-tfstate" }
variable "backend_s3_region" { default = "ap-northeast-2" }
variable "backend_dynamodb" { default = "sandbox-test-apne2-terraform-lock-table" }

EOF
}