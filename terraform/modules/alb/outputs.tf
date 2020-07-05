output "address" {
  value = aws_lb.devops-alb.dns_name
}

output "frontend_listener" {
  value = aws_lb_listener.frontend_listener.arn
}

