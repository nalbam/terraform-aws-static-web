output "domain" {
  value = "${aws_route53_record.default.name}"
}
