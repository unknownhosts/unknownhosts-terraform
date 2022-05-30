terraform {
  backend "s3" {
    bucket         = "lincoln-terraform-state"
    dynamodb_table = "lincoln-terraform-state-lock-network-vpc"
    encrypt        = true
    key            = "network/vpc/terraform.tfstate"
    region         = "ap-northeast-2"
  }
}
