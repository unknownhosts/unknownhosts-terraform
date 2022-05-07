
locals {
    common_tags = {
        project_name = "lincoln"
    } 
}   



terraform {
  backend "s3" {  
    key = "common/sg/terraform.tfstate"
  }  
}

provider "aws" {
  region = var.region
} 

