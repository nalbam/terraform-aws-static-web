# route53

module "domain" {
  source = "github.com/nalbam/terraform-aws-route53-alias?ref=v0.12.3"

  zone_id = var.zone_id

  name = var.domain_name

  alias_name    = aws_cloudfront_distribution.this.domain_name
  alias_zone_id = aws_cloudfront_distribution.this.hosted_zone_id
}

# resource "aws_route53_record" "this" {
#   count = length(var.domain_name)

#   zone_id = var.zone_id

#   name = element(var.domain_name, count.index)
#   type = "A"

#   alias {
#     name                   = aws_cloudfront_distribution.this.domain_name
#     zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
#     evaluate_target_health = "false"
#   }
# }
