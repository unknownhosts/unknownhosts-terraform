////////////////////////////////////////////////////////////
// Shared Configs ( Soft Link )
// ln -s ../path/to/variables/_shared_config.tf
////////////////////////////////////////////////////////////

// 1. Shared Locals
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

  name_prefix = "${local.account}-${local.env}" // ex) sandbox-test, sandbox-dev, ..

  // Backend S3, DynamoDB for Remote State
  backend_s3        = var.backend_s3
  backend_dynamodb  = var.backend_dynamodb
  backend_s3_region = var.backend_s3_region
}


// 2. Shared Variables
variable "account" {} # Required in tfvars file
variable "region" {}  # Required in tfvars file
variable "tags" { default = {} }
variable "cred_file" { default = "~/.aws/credentials" }
variable "backend_s3" { default = "sandbox-test-apne2-tfstate" }
variable "backend_s3_region" { default = "ap-northeast-2" }
variable "backend_dynamodb" { default = "sandbox-test-apne2-terraform-lock-table" }