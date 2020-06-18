output "alb_id"{
  value = aws_lb.alb.id
}
output "targetgroup_arn"{
  value = aws_lb_target_group.alb_target_group.arn
}

