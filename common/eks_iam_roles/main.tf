// 1. AWS Load Balancer Controller Service Account
resource "aws_iam_role" "load_balancer_controller" {
  name = "${local.name_prefix}-load-balancer-controller-role"

  assume_role_policy = templatefile(
    "${path.module}/policies/oidc_assumed.json",
    {
      OIDC_ARN  = local.eks_cluster_oidc_arn,
      OIDC_URL  = replace(local.eks_cluster_oidc_url, "https://", ""),
      NAMESPACE = "kube-system",
      SA_NAME = "aws-load-balancer-controller" }
  )

  tags = {
    "ServiceAccountName"      = "aws-load-balancer-controller"
    "ServiceAccountNameSpace" = "kube-system"
  }
}

resource "aws_iam_role_policy" "load_balancer_controller" {
  name   = "${local.name_prefix}-load-balancer-controller-policy"
  role   = aws_iam_role.load_balancer_controller.id
  policy = data.aws_iam_policy_document.load_balancer_controller.json
}

// 2. Cluster_autoscaler Service Account
resource "aws_iam_role" "cluster_autoscaler" {
  name = "${local.name_prefix}-cluster-autoscaler-role"

  assume_role_policy = templatefile(
    "${path.module}/policies/oidc_assumed.json",
    {
      OIDC_ARN  = local.eks_cluster_oidc_arn,
      OIDC_URL  = replace(local.eks_cluster_oidc_url, "https://", ""),
      NAMESPACE = "kube-system",
      SA_NAME = "cluster-autoscaler" }
  )

  tags = {
    "ServiceAccountName"      = "cluster-autoscaler"
    "ServiceAccountNameSpace" = "kube-system"
  }

}

resource "aws_iam_role_policy" "cluster_autoscaler" {
  name   = "${local.name_prefix}-cluster-autoscaler-policy"
  role   = aws_iam_role.cluster_autoscaler.id
  policy = data.aws_iam_policy_document.cluster_autoscaler.json
}

// 3. External_secrets Service Account
resource "aws_iam_role" "external_secrets" {
  name = "${local.name_prefix}-external-secrets-role"

  assume_role_policy = templatefile(
    "${path.module}/policies/oidc_assumed.json",
    {
      OIDC_ARN  = local.eks_cluster_oidc_arn,
      OIDC_URL  = replace(local.eks_cluster_oidc_url, "https://", ""),
      NAMESPACE = "kube-system",
      SA_NAME   = "external-secrets" }
  )

  tags = {
    "ServiceAccountName"      = "external-secrets"
    "ServiceAccountNameSpace" = "kube-system"
  }

}

resource "aws_iam_role_policy" "external_secrets" {
  name   = "${local.name_prefix}-external-secrets-policy"
  role   = aws_iam_role.external_secrets.id
  policy = data.aws_iam_policy_document.external_secrets.json
}


# 4. External DNS Service Account
resource "aws_iam_role" "external_dns" {
  name = "${local.name_prefix}-external-dns-role"

  assume_role_policy = templatefile(
    "${path.module}/policies/oidc_assumed.json",
    {
      OIDC_ARN  = local.eks_cluster_oidc_arn,
      OIDC_URL  = replace(local.eks_cluster_oidc_url, "https://", ""),
      NAMESPACE = "kube-system",
      SA_NAME = "external-dns" }
  )

  tags = {
    "ServiceAccountName"      = "external-dns"
    "ServiceAccountNameSpace" = "kube-system"
  }

}

resource "aws_iam_role_policy" "external_dns" {
  name   = "${local.name_prefix}-external-dns-policy"
  role   = aws_iam_role.external_dns.id
  policy = data.aws_iam_policy_document.external_dns.json
}


# 5. Cloudwatch-agent Service Account
#resource "aws_iam_role" "cloudwatch_agent" {
#  name = "${local.name_prefix}-cloudwatch-agent-role"
#
#  assume_role_policy = templatefile(
#    "${path.module}/policies/oidc_assumed.json",
#    {
#      OIDC_ARN  = local.eks_cluster_oidc_arn,
#      OIDC_URL  = replace(local.eks_cluster_oidc_url, "https://", ""),
#      NAMESPACE = "amazon-cloudwatch",
#      SA_NAME   = "cloudwatch-agent" }
#  )
#
#  tags = {
#    "ServiceAccountName"      = "cloudwatch-agent"
#    "ServiceAccountNameSpace" = "amazon-cloudwatch"
#  }
#
#  lifecycle {
#    # ignore_changes = [
#    #   name
#    # ]
#    create_before_destroy = true
#  }
#}
#
#resource "aws_iam_role_policy_attachment" "cloudwatch_agent_CloudWatchAgentServerPolicy" {
#  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
#  role       = aws_iam_role.cloudwatch_agent.name
#}
