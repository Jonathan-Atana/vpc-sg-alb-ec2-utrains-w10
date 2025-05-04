resource "aws_lb_target_group" "target-gp1" {
  name     = "alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    path                = "/"
    enabled             = true
    healthy_threshold   = 3
    interval            = 10
    matcher             = 200
    timeout             = 6
    protocol            = "HTTP"
    port                = "traffic-port"
    unhealthy_threshold = 3
  }

  depends_on = [module.vpc]
}

# Attach instances to the target group
resource "aws_lb_target_group_attachment" "target-gp-a1" {
  target_group_arn = aws_lb_target_group.target-gp1.arn
  target_id        = aws_instance.server1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "target-gp-a2" {
  target_group_arn = aws_lb_target_group.target-gp1.arn
  target_id        = aws_instance.server2.id
  port             = 80
}

# Create the ALB
resource "aws_lb" "alb" {
  name                       = "alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.sg2.id]
  subnets                    = module.vpc.public_subnets
  enable_deletion_protection = false
}

# Create the ALB listener
resource "aws_lb_listener" "alb-listener" {
  port              = 80
  protocol          = "HTTP"
  load_balancer_arn = aws_lb.alb.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-gp1.arn
  }
}