# variable

variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1"
  default     = "us-east-1"
}

variable "zone_id" {
  # default = ""
}

variable "certificate_arn" {
  # default = ""
}

variable "minimum_protocol_version" {
  default = "TLSv1" # TLSv1 TLSv1.2_2021
}

variable "acl" {
  default = "public-read"
}

variable "force_destroy" {
  default = false
}

variable "domain_name" {
  type    = list(string)
  default = []
}

variable "price_class" {
  default = "PriceClass_200" # PriceClass_All
}

variable "website_index" {
  default = "index.html"
}

variable "website_error" {
  default = "error.html"
}

variable "website_redirect" {
  default = ""
}

variable "viewer_protocol_policy" {
  default = "redirect-to-https"
}
