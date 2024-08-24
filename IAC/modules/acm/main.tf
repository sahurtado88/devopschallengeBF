resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.environment}-acm"
  }
}

data "aws_route53_zone" "route53_zone" {
  name = var.domain_name
  private_zone = false
}

#create a recor set in route 53 for domain validation
resource "aws_route53_record" "route53_record" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      value  = dvo.resource_record_value
    }
  }

  allow_overwrite = true
  name    = each.value.name
  type    = each.value.type
  zone_id = data.aws_route53_zone.route53_zone.zone_id
  records = [each.value.value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.route53_record : record.fqdn]
}


