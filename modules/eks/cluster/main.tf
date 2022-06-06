data "aws_partition" "current" {}

resource "aws_eks_cluster" "this" {
  count = var.create ? 1 : 0

  # Required
  name     = var.cluster_name
  role_arn = try(aws_iam_role.this[0].arn, var.iam_role_arn)

  vpc_config {
    subnet_ids = var.subnet_ids # Required

    security_group_ids = compact(distinct(concat(var.additional_security_group_ids, [local.cluster_security_group_id])))

    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    public_access_cidrs     = var.public_access_cidrs
  }

  # Optional
  version = var.cluster_version

  enabled_cluster_log_types = var.cluster_enabled_log_types

  kubernetes_network_config {
    ip_family         = var.cluster_ip_family
    service_ipv4_cidr = var.cluster_service_ipv4_cidr
  }

  tags = merge(
    var.tags,
    var.cluster_tags,
  )

  depends_on = [
    aws_iam_role_policy_attachment.this,
    aws_security_group_rule.this,
    aws_cloudwatch_log_group.this
  ]

}

# IRSA

data "tls_certificate" "this" {
  count = var.create && var.enable_irsa ? 1 : 0

  url = aws_eks_cluster.this[0].identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "oidc_provider" {
  count = var.create && var.enable_irsa ? 1 : 0

  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.this[0].certificates.0.sha1_fingerprint]
  url             = aws_eks_cluster.this[0].identity[0].oidc[0].issuer

  tags = merge(
    { Name = "${var.cluster_name}-eks-oidc" },
    var.tags
  )
}

////////////////////////////
// EKS Addon
// Example
// cluster_addons = {
//   coredns = {
//     resolve_conflicts = "OVERWRITE"
//   }
//   kube-proxy = {}
//   vpc-cni = {
//     resolve_conflicts = "OVERWRITE"
//   }
// }
////////////////////////////

resource "aws_eks_addon" "this" {
  for_each = { for k, v in var.cluster_addons : k => v if var.create }

  cluster_name = aws_eks_cluster.this[0].name
  addon_name   = try(each.value.name, each.key)

  addon_version = lookup(each.value, "addon_version", null)
  resolve_conflicts = lookup(each.value, "resolve_conflicts", null)
  service_account_role_arn = lookup(each.value, "service_account_role_arn", null)

  lifecycle {
    ignore_changes = [
      modified_at
    ]
  }

  tags = var.tags
}


################################################################################
# Cluster Security Group
# Defaults follow https://docs.aws.amazon.com/eks/latest/userguide/sec-group-reqs.html
################################################################################
locals {
  cluster_sg_name = coalesce(var.cluster_security_group_name, "${var.cluster_name}-cluster")

  cluster_security_group_id = aws_security_group.this.id
  vpc_cidr_block            = var.vpc_cidr

  cluster_security_group_rules = {
    ingress_nodes_443 = {
      description                = "Node groups to cluster API"
      protocol                   = "tcp"
      from_port                  = 443
      to_port                    = 443
      type                       = "ingress"
      source_node_security_group = false
      cidr_blocks                = [local.vpc_cidr_block]
    }
    egress_nodes_443 = {
      description                = "Cluster API to node groups"
      protocol                   = "tcp"
      from_port                  = 443
      to_port                    = 443
      type                       = "egress"
      source_node_security_group = false
      cidr_blocks                = [local.vpc_cidr_block]
    }
    egress_nodes_kubelet = {
      description                = "Cluster API to node kubelets"
      protocol                   = "tcp"
      from_port                  = 10250
      to_port                    = 10250
      type                       = "egress"
      source_node_security_group = false
      cidr_blocks                = [local.vpc_cidr_block]
    }
  }
}

resource "aws_security_group" "this" {

  name        = local.cluster_sg_name
  description = var.cluster_security_group_description
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    { "Name" = local.cluster_sg_name },
    var.cluster_security_group_tags
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "this" {
  for_each = { for k, v in merge(local.cluster_security_group_rules, var.cluster_security_group_additional_rules) : k => v }

  # Required
  security_group_id = aws_security_group.this.id
  protocol          = each.value.protocol
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  type              = each.value.type
  cidr_blocks       = each.value.cidr_blocks
}

# IAM Role

locals {
  iam_role_name = coalesce(var.iam_role_name, "${var.cluster_name}-cluster-role")

  policy_arn_prefix = "arn:${data.aws_partition.current.partition}:iam::aws:policy"
}

resource "aws_iam_role" "this" {
  count = var.create_iam_role ? 1 : 0

  name = local.iam_role_name
  path = var.iam_role_path

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

  tags = merge(var.tags, var.iam_role_tags)
}


resource "aws_iam_role_policy_attachment" "this" {
  for_each = var.create_iam_role ? toset(compact(distinct(concat([
    "${local.policy_arn_prefix}/AmazonEKSClusterPolicy",
    "${local.policy_arn_prefix}/AmazonEKSVPCResourceController",
  ], var.iam_role_additional_policies)))) : toset([])

  policy_arn = each.value
  role       = aws_iam_role.this[0].name
}


resource "aws_cloudwatch_log_group" "this" {
  count = var.create && var.create_cloudwatch_log_group ? 1 : 0

  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = var.cloudwatch_log_group_retention_in_days
  kms_key_id        = var.cloudwatch_log_group_kms_key_id

  tags = var.tags
}
