output "domain" {
  value = "${module.alias.domain}"
}

output "s3_website_endpoint" {
  value = "${aws_s3_bucket.default.website_endpoint}"
}

output "cdn_domain" {
  value = "${aws_cloudfront_distribution.default.domain_name}"
}
