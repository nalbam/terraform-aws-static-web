# bucket

resource "aws_s3_bucket" "this" {
  bucket = element(var.domain_name, 0)

  acl           = "public-read"
  force_destroy = true

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket_object" "this" {
  count = var.index_html != "" ? 1 : 0

  bucket = aws_s3_bucket.this.bucket
  source = var.index_html
  key    = "index.html"

  content_type = "text/html"
  acl          = "public-read"
}
