variable "AWS_REGION" {}
variable "AMIS"{}
variable "KEYPAIR_NAME" {}
variable "JENKINS_INSTANCE_TYPE" {}
variable "instance_security_group_id" {}
variable "NAME" {
  default = "autoscaling"
}
variable "private_subnets" {}
variable "instance_profile" {}

