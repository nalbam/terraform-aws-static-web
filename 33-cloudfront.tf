# cloudfront

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = local.domain_name
}

resource "aws_cloudfront_distribution" "this" {
  origin {
    origin_id   = "S3-${local.domain_name}"
    domain_name = aws_s3_bucket.this.bucket_regional_domain_name

    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = 30
      origin_ssl_protocols     = [
        "SSLv3",
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2",
      ]
    }

    # s3_origin_config {
    #   origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    # }
  }

  aliases = var.domain_name

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.website_index

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

    target_origin_id = "S3-${local.domain_name}"

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

  price_class = var.price_class

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
    minimum_protocol_version = var.minimum_protocol_version
    ssl_support_method       = "sni-only"
  }
}
