resource "aws_security_group" "instance_security_group" {
  vpc_id      = var.vpc_id
  name        = "${terraform.workspace}-${var.name}-sg"
  description = "security group that allows all ingress from alb to instances"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.jenkins_sg
    security_groups = [aws_security_group.alb_security_group.id]
  }
  tags = {
    Name = "${terraform.workspace}-${var.name}-sg"
  }
}

resource "aws_security_group" "alb_security_group" {
  vpc_id      = var.vpc_id
  name        = "${terraform.workspace}-${var.name}-ALB-sg"
  description = "security group that allows all ingress and all egress traffic to alb"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = var.jenkins_sg_ports
    content {
      from_port = ingress.key
      to_port   = ingress.key
      protocol  = "tcp"
      cidr_blocks = [ingress.value]
    }
  }
  tags = {
    Name = "${terraform.workspace}-${var.name}-ALB-sg"
  }
}
