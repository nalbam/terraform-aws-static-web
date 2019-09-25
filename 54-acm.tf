# acm

resource "aws_acm_certificate" "cert" {
  count = var.dns_root != "" ? length(var.domain_name) : 0

  domain_name = element(var.domain_name, count.index)

  validation_method = "DNS"
}

resource "aws_route53_record" "cert" {
  count = var.dns_root != "" ? length(var.domain_name) : 0

  zone_id = data.aws_route53_zone.this[0].id
  name    = aws_acm_certificate.cert[count.index].domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.cert[count.index].domain_validation_options[0].resource_record_type
  ttl     = 60

  records = [
    aws_acm_certificate.cert[count.index].domain_validation_options[0].resource_record_value,
  ]
}

resource "aws_acm_certificate_validation" "cert" {
  count = var.dns_root != "" ? length(var.domain_name) : 0

  certificate_arn = aws_acm_certificate.cert[count.index].arn

  validation_record_fqdns = [
    aws_route53_record.cert[count.index].fqdn,
  ]
}
