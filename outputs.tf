output "vpc_id" {
  type  = string
  value = aws_vpc.main.id
}

output "pub_subnets" {
  type  = list(string)
  value = aws_subnet.pub.*.id
}

output "priv_subnets" {
  type  = list(string)
  value = aws_subnet.priv.*.id
}
