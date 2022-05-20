locals {
    common_tags = {
        project_name = "lincoln"
    } 
}   

provider "aws" {
  region = var.region
} 

