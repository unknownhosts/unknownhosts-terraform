// IAM Role
resource "aws_iam_role" "nodegroup" {
  name               = "${local.name_prefix}-managed-worker-node"
  assume_role_policy = data.aws_iam_policy_document.nodegroup_assumed_role_policy.json
  tags = merge(
    {
      Name = "${local.name_prefix}-nodegroup-role"
    },
    local.tags
  )
}

locals {
  nodegroup_policies = [
    "AmazonEKSWorkerNodePolicy",
    "AmazonEKS_CNI_Policy",
    "AmazonEC2ContainerRegistryReadOnly"
  ]
}

resource "aws_iam_role_policy_attachment" "nodegroup" {
  for_each = toset(local.nodegroup_policies)

  role       = aws_iam_role.nodegroup.name
  policy_arn = "arn:aws:iam::aws:policy/${each.value}"
}