bucket = "${var.environmentName}-${var.accountName}-terraformState-s3"
region = var.region
dynamodb_table  = "${var.environmentName}-${var.accountName}-terraformStatelock-dynamodb"
encrypt = true
