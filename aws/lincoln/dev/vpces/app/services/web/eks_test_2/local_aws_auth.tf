locals {
  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::661078097983:user/jordan.kim"
      username = "jordan.kim"
      groups   = ["system:masters"]
    },
  ]

  aws_auth_accounts = [
    var.lincoln_aws_account_id
  ]
}
