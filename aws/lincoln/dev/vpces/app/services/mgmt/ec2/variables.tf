
variable "region" {
    default = "ap-northeast-2"
}  

variable "project_name" {
    type    = string
}

variable "resource_name" {
    type    = string
}

variable "environment_name" {
    type    = string
}


variable "ec2_atlantis_instnace_type" {
    type    = string
}

variable "tags" {
}

variable "remote_state_bucket_name" {
}
