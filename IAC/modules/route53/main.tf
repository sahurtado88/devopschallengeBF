// modules/route53/main.tf
resource "aws_route53_zone" "this" {
  name = var.domain_name
}

resource "aws_route53_record" "elb" {
  zone_id = aws_route53_zone.this.zone_id
  name    = var.subdomain
  type    = "CNAME"
  ttl     = 300
  records = [var.elb_dns_name]
}

