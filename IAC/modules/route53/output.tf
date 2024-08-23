output "zone_id" {
  value = aws_route53_zone.this.zone_id
}

output "elb_record" {
  value = aws_route53_record.elb.name
}
