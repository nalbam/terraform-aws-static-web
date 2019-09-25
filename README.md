# terraform-aws-static-web

## usage
```
module "domain" {
  source = "github.com/nalbam/terraform-aws-route53"

  domain = "${var.domain}"
}

module "demo-static" {
  source = "github.com/nalbam/terraform-aws-static-web"

  region = "${var.region}"

  zone_id = "${module.domain.zone_id}"
  certificate_arn = "${module.domain.certificate_arn}"

  domain_name = [
    "www.${var.domain}",
    "${var.domain}",
  ]
}
```
