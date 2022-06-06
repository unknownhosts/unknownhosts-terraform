locals {
  prefix = format("%s-%s-apne2", var.account, var.env)

  account   = var.account
  cred_file = var.cred_file
  region    = var.region
  env       = var.env


  tags = merge(var.tags,
    {
      Owner       = var.owner,
      Environment = var.env
      Team        = var.team
  })
}