resource "aws_lb_target_group" "target" {
  name                 = "${var.name}-target-group"
  deregistration_delay = var.deregistration_delay
  port                 = var.alb_port
  protocol             = local.ports[var.alb_port]
  vpc_id               = data.aws_vpc.vpc.id
  tags = {
    Name          = "${var.name}-target-group"
    resource_type = "Target Group"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.lb.arn
  port              = var.alb_port
  protocol          = local.ports[var.alb_port]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target.arn
  }
}

resource "aws_alb" "lb" {
  name               = "${var.name}-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [data.aws_subnet.public.id, data.aws_subnet.private.id]
  tags = {
    Name          = "${var.name}-alb"
    resource_type = "Load Balancer"
  }
}

resource "aws_security_group" "alb" {
  name        = "${var.name}-lb-sg"
  description = "${var.name} Load Balancer security group, allow TLS inbound traffic"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    description = "Allow ingress"
    from_port   = var.alb_port
    to_port     = var.alb_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name          = "${var.name}-alb-sg"
    resource_type = "Security Group"
  }
}
