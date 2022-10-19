# general
variable "stack_name" {
  type = string
}

variable "region" {
  type    = string
  default = "us-east_1"
}

variable "vpc_name" {
  type = string
}

# vpc
variable "enable_dns_hostnames" {
  type    = bool
  default = false
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "enable_igw" {
  type        = string
  description = "Boolean indicating internet gateway deployment"
}

variable "instance_tenancy" {
  type    = string
  default = "default"
}

variable "vpc_cidr" {
  type = string
}

# subnet public
variable "pub_avail_zones" {
  type = list(any)
}

variable "pub_cidrs" {
  type = list(any)
}

variable "pub_map_ip" {
  type        = bool
  default     = false
  description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP address"
}

# subnet private
variable "priv_avail_zones" {
  type = list(any)
}

variable "priv_cidrs" {
  type = list(any)
}

variable "priv_map_ip" {
  type        = bool
  default     = false
  description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP address"
}

variable "priv_nat_gateway" {
  type        = bool
  default     = false
  description = "Specify true to deploy a public nat gateway"
}
