
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

variable "lock_name" {
  type    = set(string)
  default = [
    "global-ddb",
    "global-iam",
    "global-s3",
    "vpces-app-network-vpc",
    "vpces-app-services-common-keypair"
  ]      
}