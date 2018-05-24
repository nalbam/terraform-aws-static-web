resource "aws_s3_bucket" "default" {
  bucket = "${var.domain_name}"
  acl = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket_object" "default" {
  bucket = "${aws_s3_bucket.default.bucket}"
  source = "data/index.html"
  key = "index.html"
}

resource "aws_cloudfront_distribution" "default" {
  origin {
    origin_id = "${var.domain_name}"
    domain_name = "${var.domain_name}.s3.amazonaws.com"

    custom_origin_config {
      http_port = "80"
      https_port = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = [
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2"
      ]
    }
  }

  # If using route53 aliases for DNS we need to declare it here too, otherwise we'll get 403s.
  aliases = [
    "${var.domain_name}"
  ]

  enabled = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods = [
      "HEAD",
      "DELETE",
      "POST",
      "GET",
      "OPTIONS",
      "PUT",
      "PATCH",
    ]
    cached_methods = [
      "HEAD",
      "GET",
    ]
    target_origin_id = "${var.domain_name}"

    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl = 0
    default_ttl = 3600
    max_ttl = 86400
  }

  price_class = "PriceClass_All"

  # This is required to be specified even if it's not used.
  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations = []
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${var.certificate_arn}"
    minimum_protocol_version = "TLSv1.1_2016"
    ssl_support_method = "sni-only"
  }
}

module "alias" {
  source = "git::https://github.com/nalbam/terraform-aws-route53-alias.git"

  zone_id = "${var.zone_id}"
  name = "${var.domain_name}"

  //alias_name = "s3-website.${var.region}.amazonaws.com"
  //alias_zone_id = "${aws_s3_bucket.default.hosted_zone_id}"

  alias_name = "${aws_cloudfront_distribution.default.domain_name}"
  alias_zone_id = "${aws_cloudfront_distribution.default.hosted_zone_id}"
}
