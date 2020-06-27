module "alb" {
  source = "./modules/alb"
  vpc_id = var.vpc_id
  alb_security_group_id = module.securitygroup.alb_security_group_id
  public_subnets = var.public_subnets
  autoscaling_group_id = module.autoscaling.autoscaling_group_id
  certificate_arn = var.certificate_arn
  name = var.name
}
module "autoscaling" {
  source = "./modules/autoscaling_group"
  keypair_name = var.keypair_name
  aws_region     = var.aws_region
  amis = var.amis
  jenkins_instance_type = var.jenkins_instance_type
  instance_security_group_id = module.securitygroup.instance_security_group_id
  private_subnets = var.private_subnets
  instance_profile = module.iamrole.instance_profile
  name = var.name
  volume_size = var.volume_size
 }
 module "securitygroup" {
  source = "./modules/security_group"
  vpc_id = var.vpc_id
  name = var.name
  jenkins_sg_ports = var.jenkins_sg_ports
}
module "iamrole" {
  source = "./modules/iamrole"
}

