locals {
  vpc_name             = "testing_vpc"
  vpc_cidr             = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_igw           = true
}

module "vpc" {
  source               = "./.."
  vpc_name             = local.vpc_name
  vpc_cidr             = local.vpc_cidr
  enable_dns_hostnames = local.enable_dns_hostnames
  enable_igw           = local.enable_igw
}
