# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket         = "lincoln-dev-s3-terraform-state"
    dynamodb_table = "lincoln-dev-ddb-tfstate-lock-vpces-app-services-common-sg"
    encrypt        = true
    key            = "vpces/app/services/common/sg/terraform.tfstate"
    region         = "ap-northeast-2"
  }
}