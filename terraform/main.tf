module "alb" {
  source = "./modules/alb"
  vpc_id = var.vpc_id
  alb_security_group_id = module.securitygroup.alb_security_group_id
  public_subnets = var.public_subnets
  autoscaling_group_id = module.autoscaling.autoscaling_group_id
}
module "autoscaling" {
  source = "./modules/autoscaling_group"
  KEYPAIR_NAME = var.KEYPAIR_NAME
  AWS_REGION     = var.AWS_REGION
  AMIS = var.AMIS
  JENKINS_INSTANCE_TYPE = var.JENKINS_INSTANCE_TYPE
  instance_security_group_id = module.securitygroup.instance_security_group_id
  private_subnets = var.private_subnets
  instance_profile = module.iamrole.instance_profile
 }
 module "securitygroup" {
  source = "./modules/security_group"
  vpc_id = var.vpc_id
}
module "iamrole" {
  source = "./modules/iamrole"
}
