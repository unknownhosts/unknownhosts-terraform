# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
provider "aws" {
    region = var.region

    default_tags {
        tags = {
            ProjectName         = var.project_name
            EnvironmentName     = var.environment_name
            ResourceName        = var.resource_name
            TerraformPath       = "vpces/app/services/web/eks"
        }
    }
} 
