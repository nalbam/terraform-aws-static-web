# terraform-aws-static-web

## usage

```
module "demo-static" {
  source = "github.com/nalbam/terraform-aws-static-web"

  region = "${var.region}"

  domain_name = [
    "www.${var.domain}",
    "${var.domain}",
  ]
}
```
