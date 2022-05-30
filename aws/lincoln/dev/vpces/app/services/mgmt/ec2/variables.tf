
variable "region" {
    default = "ap-northeast-2"
}  

variable "project_name" {
    default = "lincoln"
} 

variable "env_name" {
    type        = string
    default     = "prod"
    description = "environment name"
}


variable "ec2_atlantis_instnace_type" {
    default = "t2.micro"
}