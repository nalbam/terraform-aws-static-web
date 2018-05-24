module "domain" {
  source = "git::https://github.com/nalbam/terraform-aws-route53.git"
  domain = "${var.domain}"
}

module "alias" {
  source = "git::https://github.com/nalbam/terraform-aws-route53-alias.git"

  zone_id = "${var.zone_id}"
  name = "${var.name}.${var.domain}"

  alias_name = "s3-website-${var.region}.amazonaws.com"
  alias_zone_id = "${aws_s3_bucket.default.hosted_zone_id}"

  //  alias_name = "${aws_cloudfront_distribution.cdn.domain_name}"
  //  alias_zone_id = "${aws_cloudfront_distribution.cdn.hosted_zone_id}"
}

resource "aws_s3_bucket" "default" {
  bucket = "${var.name}.${var.domain}"
  acl = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

//resource "aws_cloudfront_distribution" "cdn" {
//  origin {
//    origin_id = "${var.name}.${var.domain}"
//    domain_name = "${var.name}.${var.domain}.s3.amazonaws.com"
//  }
//
//  # If using route53 aliases for DNS we need to declare it here too, otherwise we'll get 403s.
//  aliases = [
//    "${var.name}.${var.domain}"
//  ]
//
//  enabled = true
//  default_root_object = "index.html"
//
//  default_cache_behavior {
//    allowed_methods = [
//      "GET",
//      "HEAD",
//      "OPTIONS"
//    ]
//    cached_methods = [
//      "GET",
//      "HEAD"
//    ]
//    target_origin_id = "${var.name}.${var.domain}"
//
//    forwarded_values {
//      query_string = true
//      cookies {
//        forward = "none"
//      }
//    }
//
//    viewer_protocol_policy = "allow-all"
//    min_ttl = 0
//    default_ttl = 3600
//    max_ttl = 86400
//  }
//
//  # The cheapest priceclass
//  price_class = "PriceClass_100"
//
//  # This is required to be specified even if it's not used.
//  restrictions {
//    geo_restriction {
//      restriction_type = "none"
//      locations = []
//    }
//  }
//
//  viewer_certificate {
//    cloudfront_default_certificate = true
//  }
//}
