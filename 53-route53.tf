# route53

module "domain" {
  source = "github.com/nalbam/terraform-aws-route53-alias?ref=v1.0.1"

  zone_id = var.zone_id

  name = var.domain_name

  alias_name    = aws_cloudfront_distribution.this.domain_name
  alias_zone_id = aws_cloudfront_distribution.this.hosted_zone_id
}
