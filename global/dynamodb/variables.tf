
variable "region" {
    default = "ap-northeast-2"
}  

variable "resource_name" {
  type    = set(string)
  default = [
    "common-vpc",
    "common-keypair",
    "mgmt-ec2"
  ]      
}