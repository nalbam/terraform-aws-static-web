variable "region" {
  default = "ap-northeast-2"
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

variable "index_html" {
  default = ""
}

variable "viewer_protocol_policy" {
  default = "redirect-to-https"
}
