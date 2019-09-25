# variable

variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1"
}

variable "domain_root" {
  default = ""
}

variable "domain_name" {
  type    = list(string)
  default = []
}

variable "index_html" {
  default = ""
}

variable "viewer_protocol_policy" {
  default = "redirect-to-https"
}
