terraform {
  required_version = "= 0.12.18"

  backend "s3" {
    key            = "terraform/examples/atlantis/terraform/test/terraform.tfstate"
  }
}