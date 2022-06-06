locals {

  # Remote State
  eks_cluster_oidc_arn = data.terraform_remote_state.main["eks/cluster"].outputs.cluster_oidc_arn
  eks_cluster_oidc_url = data.terraform_remote_state.main["eks/cluster"].outputs.cluster_oidc_url
}