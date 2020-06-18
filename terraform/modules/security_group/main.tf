resource "aws_security_group" "instance_security_group" {
  vpc_id      = var.vpc_id
  name        = "${terraform.workspace}-${var.NAME}-sg"
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
    cidr_blocks = ["3.230.173.236/32","172.31.68.8/32"]
    security_groups = [aws_security_group.alb_security_group.id]
  }
  tags = {
    Name = "${terraform.workspace}-${var.NAME}-sg"
  }
}

resource "aws_security_group" "alb_security_group" {
  vpc_id      = var.vpc_id
  name        = "${terraform.workspace}-${var.NAME}-ALB-sg"
  description = "security group that allows all ingress and all egress traffic to alb"
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
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${terraform.workspace}-${var.NAME}-ALB-sg"
  }
}

