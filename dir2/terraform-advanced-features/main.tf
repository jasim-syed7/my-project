module "vpc" {
  source            = "./modules/vpc"
  region            = var.region
  subnets           = var.subnets
  deploy_nat_gateway = var.deploy_nat_gateway
}

module "ec2" {
  source        = "./modules/ec2"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = values(module.vpc.subnet_ids)[0] # Use first public subnet
  key_name      = var.key_name
  instance_type = var.instance_type
  instance_count = var.instance_count
}
