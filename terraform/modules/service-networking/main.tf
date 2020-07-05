resource "aws_lb_target_group" "lb_target_group" {
  name        = var.tg_name
  port        = var.tg_port
  protocol    = var.tg_protocol
  vpc_id      = var.vpc_id
  target_type = var.tg_ip

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 4
    path                = var.healthcheck_path
    matcher             = "200,302"
  }

  deregistration_delay = 30
  # tags = "${var.tags}"
}

resource "aws_cloudwatch_log_group" "log-group" {
  name = var.log_group_name

  tags = var.tags
}

resource "aws_alb_target_group_attachment" "lb_target_group" {
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  port             = var.tg_port
  target_id        = var.tg_instanceid
}

resource "aws_lb_listener_rule" "host_based_routing" {
  listener_arn = var.listener_arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
  condition {
    field  = "host-header"
    values = [var.host_header]
  }
}

