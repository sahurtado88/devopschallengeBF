module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
}
module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "elb" {
  source              = "./modules/elb"
  elb_sg_id           = module.sg.elb_sg_id
  public_subnets_cidr = module.vpc.public_subnets
  ssl_certificate_arn = module.acm.ssl_certificate_arn

}

module "acm" {
  source = "./modules/acm"
  domain_name = var.domain_name
}

module "route53" {
  source       = "./modules/route53"
  elb_dns_name = module.elb.elb_dns_name
  domain_name = var.domain_name
  subdomain = var.subdomain
}