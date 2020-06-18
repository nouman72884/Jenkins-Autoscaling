data "template_file" "userdata" {
  template = "${file("${path.module}/template/install_dependencies.sh")}"
}

resource "aws_launch_configuration" "launchconfiguration" {
  name_prefix     = "${terraform.workspace}-${var.NAME}-launchconfiguration"
  image_id        = var.amis
  instance_type   = var.jenkins_instance_type
  key_name        = var.keypair_name
  security_groups = [var.instance_security_group_id]
  iam_instance_profile = var.instance_profile
  user_data = data.template_file.userdata.template
  root_block_device {
    volume_size  = var.volume_size 
  }
  lifecycle {
    create_before_destroy = true
}
}
resource "aws_autoscaling_group" "autoscaling" {
  name                      = "${terraform.workspace}-${var.NAME}-autoscaling"
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
    value               = "${terraform.workspace}_${var.NAME}"
    propagate_at_launch = true
  }
}





