variable "vpc_id" {}
variable "public_subnets" {}
variable "NAME" {
  default = "alb"
}
variable "alb_security_group_id" {}
variable "autoscaling_group_id" {}

