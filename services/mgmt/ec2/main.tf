
locals {
    common_tags = {
        project_name = "lincoln"
    } 
}   

terraform {
  backend "s3" {  
    key = "mgmt/ec2/terraform.tfstate"
    bucket = "prod-lincoln-terraform-state"
    region = "ap-northeast-2"  
    dynamodb_table = "prod-lincoln-terraform-state-lock-mgmt-ec2"
    encrypt = true        
  }  
}

provider "aws" {
  region = var.region
} 

