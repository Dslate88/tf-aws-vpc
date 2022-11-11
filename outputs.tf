output "vpc_id" {
  value = aws_vpc.main.id
}

output "pub_subnets" {
  value = aws_subnet.public.*.id
}

output "priv_subnets" {
  value = aws_subnet.private.*.id
}

output "pub_route_table" {
  value = aws_route_table.public.id
}

output "priv_route_table" {
  value = aws_route_table.private.id
}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}

output "pub_subnet_cidrs" {
  value = aws_subnet.public.*.cidr_block
}

output "priv_subnet_cidrs" {
  value = aws_subnet.private.*.cidr_block
}

output "pub_route_table_id" {
  value = aws_route_table.public.id
}

output "priv_route_table_id" {
  value = aws_route_table.private.id
}
