# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket         = "lincoln-dev-s3-terraform-state"
    dynamodb_table = "lincoln-dev-ddb-tfstate-lock-vpces-app-services-mgmt-sg"
    encrypt        = true
    key            = "vpces/app/services/mgmt/sg/terraform.tfstate"
    region         = "ap-northeast-2"
  }
}
