module "domain" {
  source = "git::https://github.com/nalbam/terraform-aws-route53.git"
  domain = "${var.domain}"
}

module "alias" {
  source = "git::https://github.com/nalbam/terraform-aws-route53-alias.git"

  zone_id = "${var.zone_id}"
  name = "${var.domain_name}"
  alias_name = "s3-website.ap-northeast-2.amazonaws.com"
  alias_zone_id = "${aws_api_gateway_domain_name.default.cloudfront_zone_id}"
}

module "record" {
  source = "git::https://github.com/nalbam/terraform-aws-route53-record.git"

  zone_id = "${module.domain.zone_id}"
  name = "bot-api.${var.domain}"
  type = "CNAME"
  records = [
    "s3-website.ap-northeast-2.amazonaws.com"
  ]
}

resource "aws_s3_bucket" "default" {
  bucket = "s3-website-test.${var.domain}"
  acl = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}
