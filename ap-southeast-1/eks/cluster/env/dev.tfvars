// Shared Variables
region  = "ap-southeast-1"
account = "sandbox"
tags    = {}

// Private Variables
cluster_enabled_log_types = []
cluster_version = "1.21"
enable_irsa = true
cluster_addons = []
endpoint_private_access = true
endpoint_public_access = true
public_access_cidrs = ["0.0.0.0/0"]
cloudwatch_log_group_retention_in_days = 30