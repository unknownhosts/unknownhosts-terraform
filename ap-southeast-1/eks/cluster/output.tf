# EKS Cluster
output "cluster_arn" {
  value = module.eks_cluster.cluster_arn
}

output "cluster_api_endpoint" {
  value = module.eks_cluster.cluster_api_endpoint
}

output "cluster_id" {
  value = module.eks_cluster.cluster_id
}

output "cluster_certificatie_authority" {
  value = module.eks_cluster.cluster_certificatie_authority
}

output "cluster_identity" {
  value = module.eks_cluster.cluster_identity
}

output "cluster_platform_version" {
  value = module.eks_cluster.cluster_platform_version
}

output "cluster_vpc_config" {
  value = module.eks_cluster.cluster_vpc_config
}

# EKS Cluster Security Group
output "cluster_sg_arn" {
  value = module.eks_cluster.cluster_sg_arn
}

output "cluster_sg_id" {
  value = module.eks_cluster.cluster_sg_id
}

output "cluster_oidc_arn" {
  value = module.eks_cluster.cluster_oidc_arn
}

output "cluster_oidc_url" {
  value = module.eks_cluster.cluster_oidc_url
}