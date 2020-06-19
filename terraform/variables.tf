variable "aws_region" {}
variable "amis" {}
variable "jenkins_instance_type" {}
variable "keypair_name" {}
variable "public_subnets" {}
variable "private_subnets" {}
variable "vpc_id" {}
variable "certificate_arn" {}
variable "name" {}
variable "volume_size" {}
variable "jenkins_sg" {}
variable "jenkins_sg_ports" {
  type = "map"
}

