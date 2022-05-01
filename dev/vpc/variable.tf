variable "env" {
	default = "dev"
	type    = string

}

variable "account_name" {
	default = "dev-lincoln"
	type    = string
}

variable "region_a" {
	default = "ap-northeast-2a"
	type    = string
}

variable "region_b" {
	default = "ap-northeast-2b"
	type    = string
}
variable "region_c" {
	default = "ap-northeast-2c"
	type    = string
}

variable "vpc_cidr" {
	default = "10.0.0.0/22"
	type    = string
}

variable "subnet_pub_a_cidr" {
	default = "10.0.3.0/27"
	type    = string
}

variable "subnet_pub_b_cidr" {
	default = "10.0.3.32/27"
	type    = string
}
variable "subnet_pub_c_cidr" {
	default = "10.0.3.64/27"
	type    = string
}

variable "subnet_pri_a_cidr" {
	default = "10.0.0.0/24"
	type    = string
}

variable "subnet_pri_b_cidr" {
	default = "10.0.1.0/24"
	type    = string
}
variable "subnet_pri_c_cidr" {
	default = "10.0.2.0/24"
	type    = string
}

variable "subnet_pri_db_a_cidr" {
	default = "10.0.3.96/27"
	type    = string
}

variable "subnet_pri_db_b_cidr" {
	default = "10.0.3.128/27"
	type    = string
}
variable "subnet_pri_db_c_cidr" {
	default = "10.0.3.160/27"
	type    = string
}
