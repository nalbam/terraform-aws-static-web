# bucket

resource "aws_s3_bucket" "this" {
  bucket = element(var.domain_name, 0)

  force_destroy = var.force_destroy
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.bucket

  acl = var.acl
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket

  index_document {
    suffix = var.website_index
  }

  error_document {
    key = var.website_error
  }

  # routing_rule {
  #   condition {
  #     key_prefix_equals = "docs/"
  #   }
  #   redirect {
  #     replace_key_prefix_with = "documents/"
  #   }
  # }
}
