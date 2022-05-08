locals {
    common_tags = {
        project_name = "lincoln"
    } 
}   


terraform {
  backend "s3" {  
    key = "lincoln/ec2/terraform.tfstate"
  }  
}

provider "aws" {
  region = var.region
} 

