data "terraform_remote_state" "vpc" {
	backend = "s3"
	config = {
		bucket = "${terraform.workspace}-${var.project_name}-terraform-state"
		key = "env:/${terraform.workspace}/common/vpc/terraform.tfstate"
		region = var.region
	}   
}  

