resource "random_uuid" "this" {
  keepers = {
    name = var.name
  }
}

resource "aws_s3_bucket" "this" {
  bucket        = "${var.name}-${random_uuid.this.result}"
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "this" {
  depends_on = [aws_s3_bucket_ownership_controls.this]

  bucket = aws_s3_bucket.this.id
  acl    = "private"
}

