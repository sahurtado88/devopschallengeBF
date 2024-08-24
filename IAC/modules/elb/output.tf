output "elb_dns_name" {
  value = aws_lb.elb.dns_name
}

output "elb_arn" {
  value       = aws_lb.elb.arn
}