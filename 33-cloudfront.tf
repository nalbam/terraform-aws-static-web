# cloudfront

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = element(var.domain_name, 0)
}

resource "aws_cloudfront_distribution" "this" {
  origin {
    origin_id   = "S3-${element(var.domain_name, 0)}"
    domain_name = "${element(var.domain_name, 0)}.s3.amazonaws.com"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
  }

  aliases = var.domain_name

  enabled             = true
  is_ipv6_enabled     = true
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

    target_origin_id = "S3-${element(var.domain_name, 0)}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    compress = true

    # viewer_protocol_policy = "allow-all"
    viewer_protocol_policy = var.viewer_protocol_policy

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  //price_class = "PriceClass_All"
  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
    //geo_restriction {
    //  restriction_type = "whitelist"
    //  locations = [
    //    "KR"
    //  ]
    //}
  }

  viewer_certificate {
    acm_certificate_arn      = var.certificate_arn
    minimum_protocol_version = "TLSv1"
    ssl_support_method       = "sni-only"
  }
}
