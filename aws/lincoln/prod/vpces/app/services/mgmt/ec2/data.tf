
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
		bucket = "${terraform.workspace}-${var.project_name}-terraform-state"
		key = "env:/${terraform.workspace}/mgmt/sg/terraform.tfstate"
		region = var.region
	}   
}  

data "terraform_remote_state" "vpc" {
	backend = "s3"
	config = {
		bucket = "${terraform.workspace}-${var.project_name}-terraform-state"
		key = "env:/${terraform.workspace}/common/vpc/terraform.tfstate"
		region = var.region
	}   
}  

data "terraform_remote_state" "keypair" {
	backend = "s3"
	config = {
		bucket = "${terraform.workspace}-${var.project_name}-terraform-state"
		key = "env:/${terraform.workspace}/common/keypair/terraform.tfstate"
		region = var.region
	}   
}  