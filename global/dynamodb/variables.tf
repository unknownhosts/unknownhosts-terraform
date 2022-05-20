
variable "region" {
    default = "ap-northeast-2"
}  

variable "resource_name" {
  type    = set(string)
  default = [
    "global-dynamodb",
    "global-iam",
    "global-s3",
    "network-vpc",
    "common-keypair",
    "mgmt-ec2",
    "mgmt-sg"
  ]      
}