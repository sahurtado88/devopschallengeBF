output "nat_gateway_ids" {
  value = aws_nat_gateway.nat.*.id
}

output "nat_gateway_ips" {
  value = aws_nat_gateway.nat.*.public_ip
}