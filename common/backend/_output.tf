output "s3_name" {
  value = aws_s3_bucket.this.bucket
}

output "s3_arn" {
  value = aws_s3_bucket.this.arn
}

output "dynamodb_name" {
  value = aws_dynamodb_table.this.name
}