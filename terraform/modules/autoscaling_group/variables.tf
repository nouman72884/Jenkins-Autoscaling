variable "aws_region" {}
variable "amis"{}
variable "keypair_name" {}
variable "jenkins_instance_type" {}
variable "instance_security_group_id" {}
variable "NAME" {
  default = "autoscaling"
}
variable "private_subnets" {}
variable "instance_profile" {}

