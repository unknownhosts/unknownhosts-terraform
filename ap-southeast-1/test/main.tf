variable "test" {}

resource "aws_s3_bucket" "main" {
  bucket = "${var.test}-bucket13131tt"
}