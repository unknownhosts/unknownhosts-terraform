output "nodegroup_arn" {
  value = aws_eks_node_group.this.arn
}

output "nodegroup_id" {
  value = aws_eks_node_group.this.id
}

output "nodegroup_resources" {
  value = aws_eks_node_group.this.resources
}

output "nodegroup_status" {
  value = aws_eks_node_group.this.status
}

output "launch_template_id" {
  value = aws_launch_template.this.id
}
