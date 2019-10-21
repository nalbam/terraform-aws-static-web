# bucket

resource "aws_s3_bucket" "this" {
  bucket = element(var.domain_name, 0)

  acl           = "public-read"
  force_destroy = true

  website {
    index_document           = var.website_index
    error_document           = var.website_error
    redirect_all_requests_to = var.website_redirect
  }
}
