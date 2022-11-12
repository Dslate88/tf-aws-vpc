# general
variable "env" {
  type        = string
  description = "[dev/test/prod] identification"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "stack_name" {
  type        = string
  description = "Name of the stack responsible for deploying the resource"
}

variable "vpc_name" {
  type        = string
  description = "Name of the vpc and used as prefix for dependent resources"
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

# vpc endpoints
variable "enable_s3_endpoint" {
  type        = bool
  default     = false
  description = "Boolean indicating s3 endpoint deployment"
}

variable "enable_ec2_endpoint" {
  type        = bool
  default     = false
  description = "Boolean indicating ec2 endpoint deployment"
}

variable "enable_ecr_dkr_endpoint" {
  type        = bool
  default     = false
  description = "Boolean indicating ecr dkr endpoint deployment"
}

variable "enable_ecr_api_endpoint" {
  type        = bool
  default     = false
  description = "Boolean indicating ecr api endpoint deployment"
}

variable "enable_dynamodb_endpoint" {
  type        = bool
  default     = false
  description = "Boolean indicating dynamodb endpoint deployment"
}

variable "enable_ssm_endpoint" {
  type        = bool
  default     = false
  description = "Boolean indicating ssm endpoint deployment"
}
