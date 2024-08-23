// modules/elb/main.tf
resource "aws_elb" "elb" {
  name               = "${var.environment}-elb"
  security_groups    = [var.elb_sg_id]
  subnets            = var.public_subnets_cidr

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  listener {
    instance_port     = 443
    instance_protocol = "HTTPS"
    lb_port           = 443
    lb_protocol       = "HTTPS"
    #ssl_certificate_id = var.ssl_certificate_id
  }

  health_check {
    target              = "HTTP:80/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.environment}-elb"
  }
}

