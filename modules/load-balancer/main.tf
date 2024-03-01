
# Create Application Load Balancer
resource "aws_lb" "path_load_balancer" {
  name               = "microservices-path-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids
}

# Create Target Groups
resource "aws_lb_target_group" "status" {
  name     = "status-target-group"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path                = "/api/status/health"
    protocol            = "HTTP"
    interval            = 10
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "lights" {
  name     = "lights-target-group"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path                = "/api/lights"
    protocol            = "HTTP"
    interval            = 10
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "heating" {
  name     = "heating-target-group"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path                = "/api/heating"
    protocol            = "HTTP"
    interval            = 10
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Attach instances to Target Groups
resource "aws_lb_target_group_attachment" "status_attachment" {
  target_group_arn = aws_lb_target_group.status.arn
  target_id        = var.status_instance_id
}

resource "aws_lb_target_group_attachment" "lights_attachment" {
  target_group_arn = aws_lb_target_group.lights.arn
  target_id        = var.lights_instance_id
}

resource "aws_lb_target_group_attachment" "heating_attachment" {
  target_group_arn = aws_lb_target_group.heating.arn
  target_id        = var.heating_instance_id
}

#Create listener
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.path_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.status.arn
  }
}

# Create Listener Rules
resource "aws_lb_listener_rule" "status_rule" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.status.arn
  }

  condition {
    path_pattern {
      values = ["/api/status*", "/api/auth*"]
    }
  }
}

resource "aws_lb_listener_rule" "lights_rule" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lights.arn
  }

  condition {
    path_pattern {
      values = ["/api/lights*"]
    }
  }
}

resource "aws_lb_listener_rule" "heating_rule" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority     = 20

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.heating.arn
  }

  condition {
    path_pattern {
      values = ["/api/heating*"]
    }
  }
}
