remote_state {
    backend = "s3"
    generate = {
        path = "backend.tf"
        if_exists = "overwrite_terragrunt"
    }

    config = {
        bucket = "lincoln-terraform-state"
        key = "${path_relative_to_include()}/terraform.tfstate"
        region = "ap-northeast-2"
        encrypt = true
        dynamodb_table = "lincoln-terraform-state-lock-network-vpc"
    }
}

generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"

    contents = <<EOF
    provider "aws" {
    region = var.region
    } 
    EOF
}