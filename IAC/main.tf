module "backend" {
  source      = "./modules/remotebackend"
  iam_user    = var.iam_user
  bucket_name = var.bucket_name
  table_name  = var.table_name
}


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

}

module "route53" {
  source       = "./modules/route53"
  elb_dns_name = module.elb.elb_dns_name

}
