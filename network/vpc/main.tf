
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
    key = "vpc/terraform.tfstate"
  }  
}

provider "aws" {
  region = var.region
} 

