# output

output "domain" {
  value = element(var.domain_name, 0)
}

output "cdn_domain" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "cdn_zone_id" {
  value = aws_cloudfront_distribution.this.hosted_zone_id
}

# output "s3_website_endpoint" {
#   value = aws_s3_bucket.this.website_endpoint
# }
