resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    Name  = var.vpc_name,
    Stack = var.stack_name,
    Env   = var.env
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  count  = var.enable_igw ? 1 : 0
  tags = {
    Name  = "${var.vpc_name}-igw",
    Stack = var.stack_name,
    Env   = var.env
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.pub_cidrs)
  cidr_block              = element(var.pub_cidrs, count.index)
  availability_zone       = element(var.pub_avail_zones, count.index)
  map_public_ip_on_launch = var.pub_map_ip
  tags = {
    Name  = "${var.vpc_name}-${element(var.pub_avail_zones, count.index)}-public-subnet",
    Stack = var.stack_name,
    Env   = var.env
  }
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.priv_cidrs)
  cidr_block              = element(var.priv_cidrs, count.index)
  availability_zone       = element(var.priv_avail_zones, count.index)
  map_public_ip_on_launch = var.priv_map_ip
  tags = {
    Name  = "${var.vpc_name}-${element(var.priv_avail_zones, count.index)}-private-subnet",
    Stack = var.stack_name,
    Env   = var.env
  }
}

resource "aws_eip" "nat_gw" {
  count = var.priv_nat_gateway ? length(var.priv_cidrs) : 0
  vpc   = true
}

resource "aws_nat_gateway" "default" {
  count         = var.priv_nat_gateway ? length(var.priv_cidrs) : 0
  allocation_id = aws_eip.nat_gw[count.index].id
  subnet_id     = element(aws_subnet.public.*.id, 0)
  depends_on    = [aws_internet_gateway.gw]
  tags = {
    Name  = "${var.vpc_name}-${element(var.priv_avail_zones, count.index)}-nat-gw",
    Stack = var.stack_name,
    Env   = var.env
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name  = "${var.vpc_name}-private-route-table",
    Stack = var.stack_name,
    Env   = var.env
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name  = "${var.vpc_name}-public-route-table",
    Stack = var.stack_name,
    Env   = var.env
  }
}

resource "aws_route" "public_internet_gateway" {
  count                  = var.enable_igw ? 1 : 0
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw[count.index].id
}

resource "aws_route" "private_nat_gateway" {
  count                  = var.priv_nat_gateway ? 1 : 0
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.default[count.index].id
}

resource "aws_route_table_association" "public" {
  count          = length(var.pub_cidrs)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.priv_cidrs)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "default" {
  name        = "${var.vpc_name}-default-sg"
  description = "Default sg self-ref ingress & all engress"
  vpc_id      = aws_vpc.main.id
  depends_on  = [aws_vpc.main]
  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }
  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }
  tags = {
    Name  = "${var.vpc_name}-default-security-group",
    Stack = var.stack_name,
    Env   = var.env
  }
}
