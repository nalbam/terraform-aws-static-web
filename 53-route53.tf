# route53

data "aws_route53_zone" "this" {
  count = var.domain_root != "" ? 1 : 0

  name = var.domain_root
}

resource "aws_route53_record" "this" {
  count = var.domain_root != "" ? length(var.domain_name) : 0

  zone_id = data.aws_route53_zone.this[0].zone_id

  name = element(var.domain_name, count.index)
  type = "A"

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = "false"
  }
}
