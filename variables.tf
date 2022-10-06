variable "region" {
  type    = string
  default = "us-east_1"
}

variable "vpc_name" {
  type = string
}

variable "enable_dns_support" {
  type    = string
  default = true
}

variable "enable_dns_hostnames" {
  type    = string
  default = false
}

variable "vpc_cidr" {
  type = string
}

variable "instance_tenancy" {
  type    = string
  default = "default"
}
