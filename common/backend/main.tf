# Backend Resources

# 1. S3
resource "aws_s3_bucket" "this" {
  bucket = format("%s-tfstate", local.prefix)

  tags = merge(
    local.tags,
    {
      Name = format("%s-tfstate", local.prefix)
    }
  )
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}


# 2. DynamoDB
resource "aws_dynamodb_table" "this" {
  name = format("%s-terraform-lock-table", local.prefix)
  hash_key = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = merge(
    local.tags,
    {
      Name = format("%s-terraform-lock", local.prefix)
    }
  )
}