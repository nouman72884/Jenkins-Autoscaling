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
    cidr_blocks = ["18.212.37.142/32","172.31.89.80/32"]
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

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${terraform.workspace}-${var.name}-ALB-sg"
  }
}
