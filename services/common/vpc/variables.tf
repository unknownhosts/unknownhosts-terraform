
variable "region" {
    default = "ap-northeast-2"
}  

variable "env_name" {
    type        = string
    default     = "prod"
    description = "environment name"
}

variable "project_name" {
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

variable "private_subnet_suffix" {
  description = "Suffix to append to private subnets name"
  type        = list(string)
  default     = ["private-frontend-subnet",
                 "private-frontend-subnet",
                 "private-backend-subnet",
                 "private-backend-subnet",
                 "private-mgmt-subnet",
                 "private-mgmt-subnet",
                 "private-db-subnet",
                 "private-db-subnet"
              ]
}

variable "private_route_suffix" {
  description = "Suffix to append to dev web was private subnets name"
  type        = list(string)
  default     = ["private-frontend-route",
                 "private-frontend-route",
                 "private-backend-route",
                 "private-backend-route",
                 "private-mgmt-route",
                 "private-mgmt-route",
                 "private-db-route",
                 "private-db-route",
                ]
}

variable "public_route_suffix" {
  description = "Suffix to append to public subnets name"
  type        = string
  default     = "publc-route"
}

variable "public_subnet_suffix" {
  description = "Suffix to append to public subnets name"
  type        = string
  default     = "public-subnet"
}