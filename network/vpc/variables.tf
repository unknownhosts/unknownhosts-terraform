
variable "region" {
    default = "ap-northeast-2"
}  

variable "env_name" {
    type        = string
    default     = "prod"
    description = "environment name"
}
variable "account_name" {
    type        = string
    default     = "lincoln"
    description = "aws account name"
}

variable "vpc_cidr" {
    type        = string
    default     = "10.0.0.0/16"
    description = "vpc cidr"
}

variable "vpc_azs" {
    type        = list
    default     = ["ap-northeast-2a",# frontend
                   "ap-northeast-2c",# frontend
                   "ap-northeast-2a",# backend 
                   "ap-northeast-2c",# backend
                   "ap-northeast-2a",# mgmt
                   "ap-northeast-2c",# mgmt
                   "ap-northeast-2a",# db
                   "ap-northeast-2c",# db
                ]
    description = "vpc azs"
}

variable "public_cidr" {
    type        = list
    default     = ["10.0.1.0/24", "10.0.2.0/24"]
    description = "public cidr"
}

variable "private_cidr" {
    type        = list
    default     = ["10.0.3.0/24", 
                   "10.0.4.0/24",
                   "10.0.5.0/24", 
                   "10.0.6.0/24",
                   "10.0.7.0/24", 
                   "10.0.8.0/24",
                   "10.0.9.0/24", 
                   "10.0.10.0/24",
                ]
    description = "private cidr"
}