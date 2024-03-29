
locals {
    common_tags = {
        AccountName   = ""
        Corp          = ""
        Csp           = ""
        Team          = "" 
        ServiceGroup  = ""
        CreatedBy     = ""
        Phase         = ""
    }
}


terraform {
  backend "s3" {  
    key = "iam/terraform.tfstate"
  }  
}

provider "aws" {
  region = var.region
} 

