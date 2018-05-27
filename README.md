# terraform-aws-static-web

## usage
```
module "domain" {
  source = "git::https://github.com/nalbam/terraform-aws-route53.git"
  domain = "${var.domain}"
}

module "demo-static" {
  source = "git::https://github.com/nalbam/terraform-aws-static-web.git"
  region = "${var.region}"

  zone_id = "${module.domain.zone_id}"
  domain_name = "demo-static.${var.domain}"
  certificate_arn = "${module.domain.certificate_arn}"
}
```
