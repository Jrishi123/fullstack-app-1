locals {
  # Group all public subnets by their Availability Zone (AZ)
  subnets_grouped_by_az = {
    for s in aws_subnet.public : s.availability_zone => [s.id]...
  }

  # From each AZ group, pick the first subnet ID (to avoid duplicates)
  subnet_az_map = {
    for az, subnet_ids in local.subnets_grouped_by_az : az => subnet_ids[0]
  }
}

resource "aws_lb" "app" {
  name               = "${var.app_name}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = values(local.subnet_az_map)  # one subnet per AZ
  security_groups    = [aws_security_group.ecs_service.id]

  tags = {
    Name = "${var.app_name}-alb"
  }
}

resource "aws_lb_target_group" "app_tg" {
  name        = "${var.app_name}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}
