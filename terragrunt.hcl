remote_state {
  backend = "s3"
  generate = {
    path      = "_backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "<TFSTATE_BUCKET>"
    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "<REGION_FOR_TFSTATE_BUCKET>"
    encrypt        = true
    dynamodb_table = "<DYNAMO_TABLE>"

    role_arn = "<ROLE_ARN_FOR_BACKEND>"
  }
}


generate "provider" {
  path = "_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "<REGION_FOR_TERRAFORM_PROVISIONIG>"
  assume_role {
    role_arn     = "<ROLE_ARN_FOR_TERRAFORM_RUNNER>"
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
}

// Shared Variables
variable "account" {} # Required in tfvars file
variable "region" {}  # Required in tfvars file
variable "tags" { default = {} }
variable "cred_file" { default = "~/.aws/credentials" }
variable "backend_s3" { default = "DEFAULT_S3_BUCKET" }
variable "backend_s3_region" { default = "DEFAULT_REGION" }
variable "backend_dynamodb" { default = "DEFAULT_DYNAMODB" }

EOF
}