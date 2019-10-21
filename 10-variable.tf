# variable

variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1"
  default     = "us-east-1"
}

variable "zone_id" {
  //default = ""
}

variable "certificate_arn" {
  //default = ""
}

variable "domain_name" {
  type    = list(string)
  default = []
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
