remote_state {
    backend = "s3"
    generate = {
        path = "backend.tf"
        if_exists = "overwrite_terragrunt"
    }

    config = {
        bucket = "lincoln-dev-s3-terraform-state"
        key = "${path_relative_to_include()}/terraform.tfstate"
        region = "ap-northeast-2"
        encrypt = true
        dynamodb_table = "lincoln-dev-ddb-tfstate-lock-${replace(path_relative_to_include(),"/","-")}"
    }
}


generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"
    #if_exists = "skip"

    contents = <<EOF
provider "aws" {
    region = var.region

    default_tags {
        tags = {
            ProjectName         = var.project_name
            EnvironmentName     = var.environment_name
            ResourceName        = var.resource_name
            TerraformPath       = "${path_relative_to_include()}"
        }
    }
} 
    EOF
}

generate "local" {
    path = "local.tf"
    #if_exists = "overwrite_terragrunt"
    if_exists = "skip"

    contents = <<EOF
locals {
}
    EOF
}

generate "tfvars" {
    path = "terraform.tfvars"
    #if_exists = "overwrite_terragrunt"
    if_exists = "skip"

    contents = <<EOF
environment_name=""
project_name=""
resource_name="${element(split("/",path_relative_to_include()),length(split("/",path_relative_to_include()))-1)}"
remote_state_bucket_name=""
tags={
}
    EOF
}

generate "variables" {
    path = "variables.tf"
    #if_exists = "overwrite_terragrunt"
    if_exists = "skip"

    contents = <<EOF
variable "region" {
    default = "ap-northeast-2"
}  

variable "environment_name" {
}

variable "project_name" {
}

variable "resource_name" {
}

variable "tags" {
}

variable "remote_state_bucket_name" {
}
   EOF
}

generate "output" {
    path = "output.tf"
    #if_exists = "overwrite_terragrunt"
    if_exists = "skip"

    contents = <<EOF
    EOF
}

generate "data" {
    path = "data.tf"
    #if_exists = "overwrite_terragrunt"
    if_exists = "skip"

    contents = <<EOF

    EOF
}

generate "resource" {
    path = "${element(split("/",path_relative_to_include()),length(split("/",path_relative_to_include()))-1)}.tf"
    #if_exists = "overwrite_terragrunt"
    if_exists = "skip"

    contents = <<EOF
# 리소스를 파일 여러개로 관리할 거면 여기에 ResourceName_NameTag 로 생성
    EOF
}

generate "main" {
    path = "main.tf"
    #if_exists = "overwrite_terragrunt"
    if_exists = "skip"

    contents = <<EOF
# 리소스를 파일 하나로 관리할 거면 여기에
    EOF
}

### test