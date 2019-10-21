# bucket

resource "aws_s3_bucket" "this" {
  bucket = element(var.domain_name, 0)

  acl = var.acl

  force_destroy = var.force_destroy

  website {
    index_document = var.website_index
    error_document = var.website_error
    # redirect_all_requests_to = var.website_redirect
  }
}
