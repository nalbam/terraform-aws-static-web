# route53

module "domain" {
  source = "github.com/nalbam/terraform-aws-route53-alias?ref=v0.12.1"

  zone_id = var.zone_id

  name = element(var.domain_name, 0)

  alias_name    = aws_api_gateway_domain_name.default.cloudfront_domain_name
  alias_zone_id = aws_cloudfront_distribution.this.hosted_zone_id
}
