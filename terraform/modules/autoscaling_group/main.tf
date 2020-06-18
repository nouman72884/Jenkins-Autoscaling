data "template_file" "userdata" {
  template = "${file("${path.module}/template/install_dependencies.sh")}"
}

resource "aws_launch_configuration" "launchconfiguration" {
  name_prefix     = "${terraform.workspace}-launchconfiguration_test"
  image_id        = var.amis
  instance_type   = var.jenkins_instance_type
  key_name        = var.keypair_name
  security_groups = [var.instance_security_group_id]
  iam_instance_profile = var.instance_profile
  user_data = data.template_file.userdata.template

  lifecycle {
    create_before_destroy = true
}
}
resource "aws_autoscaling_group" "autoscaling" {
  name                      = "${terraform.workspace}-${var.NAME}-test"
  vpc_zone_identifier       = var.private_subnets  
  #availability_zones        = data.aws_availability_zones.available.names
  launch_configuration      = aws_launch_configuration.launchconfiguration.name
  min_size                  = 1
  max_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  default_cooldown          = 300
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "${terraform.workspace}-${var.NAME}-ec2 instance"
    propagate_at_launch = true
  }
}
resource "aws_autoscaling_policy" "autoscaling_policy_scale_up" {
  name                   = "${terraform.workspace}-${var.NAME}-autoscaling-policy-scale-up_test"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.autoscaling.name
}
resource "aws_autoscaling_policy" "autoscaling_policy_scale_down" {
    name = "${terraform.workspace}-${var.NAME}-autoscaling-policy-scale-down_test"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = aws_autoscaling_group.autoscaling.name
}
resource "aws_cloudwatch_metric_alarm" "autoscaling_policy_scale_up_alarm" {
  alarm_name          = "${terraform.workspace}-${var.NAME}-autoscaling_policy_scale_up_alarm_test"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "50"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autoscaling.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.autoscaling_policy_scale_up.arn}"]
}
resource "aws_cloudwatch_metric_alarm" "autoscaling_policy_scale_down_alarm" {
  alarm_name          = "${terraform.workspace}-${var.NAME}-autoscaling_policy_scale_down_alarm_test"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "40"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autoscaling.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.autoscaling_policy_scale_down.arn}"]
}


