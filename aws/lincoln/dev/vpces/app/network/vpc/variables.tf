
variable "region" {
    default = "ap-northeast-2"
}  

variable "environment_name" {
}  

variable "project_name" {
}  

variable "vpcs_name"{
    
}

variable "resource_name" {
}

variable "tags" {
}

variable "remote_state_bucket_name" {

}

variable "vpc_cidr" {
    type        = string
    description = "vpc cidr"
}

variable "secondary_cidr" {
    type        = list(string)
}


variable "private_subnet_suffix" {
  description = "Suffix to append to private subnets name"
  type        = list(string)
}

variable "private_route_suffix" {
  description = "Suffix to append to dev web was private subnets name"
  type        = list(string)
}

variable "public_route_suffix" {
  description = "Suffix to append to public subnets name"
  type        = string
}

variable "public_subnet_suffix" {
  description = "Suffix to append to public subnets name"
  type        = string
}

variable "private_subnet_azs" {
    type        = list
    description = "private subnet azs"
}

variable "public_cidr" {
    type        = list
    description = "public cidr"
}

variable "private_cidr" {
    type        = list
    description = "private cidr"
}

variable "private_subnet_index" {
    type    = list(number)
}
