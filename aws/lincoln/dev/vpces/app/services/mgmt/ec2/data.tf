
data "aws_ami" "amazon_linux2" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

data "terraform_remote_state" "sg" {
	backend = "s3"
	config = {
		bucket = var.remote_state_bucket_name
		key = "vpces/app/services/mgmt/sg/terraform.tfstate"
		region = var.region
	}   
}  

data "terraform_remote_state" "vpc" {
	backend = "s3"
	config = {
		bucket = var.remote_state_bucket_name
		key = "vpces/app/network/vpc/terraform.tfstate"
		region = var.region
	}   
}  

data "terraform_remote_state" "keypair" {
	backend = "s3"
	config = {
		bucket = var.remote_state_bucket_name
		key = "vpces/app/services/common/keypair/terraform.tfstate"
		region = var.region
	}   
}      
