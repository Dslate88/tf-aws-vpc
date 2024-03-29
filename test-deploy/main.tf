locals {
  stack_name = "vpc_module_test"
  env        = "dev"

  # vpc
  vpc_name             = "testing_vpc"
  vpc_cidr             = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_igw           = true
  # subnet pub: evens
  pub_cidrs       = ["10.0.0.0/24", "10.0.2.0/24"]
  pub_avail_zones = ["us-east-1a", "us-east-1b"]
  pub_map_ip      = true
  # subnet priv: odds
  priv_cidrs       = ["10.0.1.0/24", "10.0.3.0/24"]
  priv_avail_zones = ["us-east-1a", "us-east-1b"]
  priv_nat_gateway = false # true costs
  # vpc endpoints
  enable_s3_endpoint      = false
  enable_ecr_dkr_endpoint = false
  enable_ecr_api_endpoint = false
  enable_ssm_endpoint     = false
}

module "vpc" {
  source     = "./.."
  stack_name = local.stack_name
  env        = local.env

  # vpc
  vpc_name             = local.vpc_name
  vpc_cidr             = local.vpc_cidr
  enable_dns_hostnames = local.enable_dns_hostnames
  enable_igw           = local.enable_igw
  # subnet public
  pub_cidrs       = local.pub_cidrs
  pub_avail_zones = local.pub_avail_zones
  pub_map_ip      = local.pub_map_ip
  # subnet private
  priv_cidrs       = local.priv_cidrs
  priv_avail_zones = local.priv_avail_zones
  priv_nat_gateway = local.priv_nat_gateway
  # vpc endpoints
  enable_s3_endpoint      = local.enable_s3_endpoint
  enable_ecr_dkr_endpoint = local.enable_ecr_dkr_endpoint
  enable_ecr_api_endpoint = local.enable_ecr_api_endpoint
  enable_ssm_endpoint     = local.enable_ssm_endpoint
}
