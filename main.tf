resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.main.id
  count  = var.enable_igw ? 1 : 0
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.pub_cidrs)
  cidr_block              = element(var.pub_cidrs, count.index)
  availability_zone       = element(var.pub_avail_zones, count.index)
  map_public_ip_on_launch = var.pub_map_ip
  tags = {
    Name = "${var.vpc_name}-${element(var.pub_avail_zones, count.index)}-public-subnet"
  }
}
