
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = var.remote_state_bucket_name
    key    = "vpces/app/network/vpc/terraform.tfstate"
    region = var.region
  }
}  