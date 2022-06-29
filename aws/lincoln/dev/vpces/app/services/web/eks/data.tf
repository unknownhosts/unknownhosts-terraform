# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa

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

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

data "terraform_remote_state" "mgmt_sg" {
	backend = "s3"
	config = {
		bucket = var.remote_state_bucket_name
		key = "vpces/app/services/mgmt/sg/terraform.tfstate"
		region = var.region
	}   
}  

data "terraform_remote_state" "iampolicy" {
	backend = "s3"
	config = {
		bucket = var.remote_state_bucket_name
		key = "global/iam/terraform.tfstate"
		region = var.region
	}   
}    