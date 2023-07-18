resource "aws_s3_bucket" "this" {
  bucket        = "k8s-cluster-scripts"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "this" {
  bucket           = aws_s3_bucket.this.id
  for_each         = fileset("scripts/", "*")
  key              = each.value
  source           = "scripts/${each.value}"
  content_encoding = "text/plain"
  etag             = filemd5("scripts/${each.value}")
}