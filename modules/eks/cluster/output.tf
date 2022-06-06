# EKS Cluster
output "cluster_arn" {
  value = aws_eks_cluster.this[0].arn
}

output "cluster_api_endpoint" {
  value = aws_eks_cluster.this[0].endpoint
}

output "cluster_id" {
  value = aws_eks_cluster.this[0].id
}

output "cluster_certificatie_authority" {
  value = aws_eks_cluster.this[0].certificate_authority
}

output "cluster_identity" {
  value = aws_eks_cluster.this[0].identity
}

output "cluster_platform_version" {
  value = aws_eks_cluster.this[0].platform_version
}

output "cluster_vpc_config" {
  value = aws_eks_cluster.this[0].vpc_config
}

# EKS Cluster Security Group
output "cluster_sg_arn" {
  value = aws_security_group.this.arn
}

output "cluster_sg_id" {
  value = aws_security_group.this.id
}

# EKS Cluster IAM Role
output "cluster_iam_arn" {
  value = aws_iam_role.this[0].arn
}

output "cluster_iam_id" {
  value = aws_iam_role.this[0].id
}

# EKS Cluster CloudWatch Log Group
output "cluster_cw_logs_arn" {
  value = aws_cloudwatch_log_group.this[0].arn
}

output "cluster_addons" {
  description = "Map of attribute maps for all EKS cluster addons enabled"
  value       = aws_eks_addon.this
}

output "cluster_oidc_arn" {
  value = aws_iam_openid_connect_provider.oidc_provider[0].arn
}

output "cluster_oidc_url" {
  value = aws_iam_openid_connect_provider.oidc_provider[0].url
}