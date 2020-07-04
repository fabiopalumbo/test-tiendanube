# Create ALB Security Group
resource "aws_security_group" "web_alb_sg" {
  name        = "terraform_example"
  description = "Used in the terraform"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = { Name = "${var.project}-${var.vpc_prefix}-web-alb-sg" }

}

# Create ALB
resource "aws_lb" "devops-alb" {
 name = "${var.lb_name}"
 load_balancer_type = "application"
 internal = false

 security_groups = ["${aws_security_group.web_alb_sg.id}"]
 subnets         = ["${var.lb_subnets}"]

 enable_cross_zone_load_balancing = true

 tags = "${var.tags}"
}

# Create Route 53 to ALB

resource "aws_route53_record" "devops-alb" {
  zone_id = "${var.r53_zoneid}"
  name    = "*.demo.test.com"
  type    = "A"

  alias {
    name                   = "${aws_lb.devops-alb.dns_name}"
    zone_id                = "${aws_lb.devops-alb.zone_id}"
    evaluate_target_health = true
  }
}


# Create Target Group
resource "aws_lb_target_group" "default-http-tg" {
  name     = "default-http-tg"
  port     = 8081
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

 health_check {
   protocol = "HTTP"
   healthy_threshold = 2
   unhealthy_threshold = 2
 }

 tags = {
  Name = "${var.project}-${var.vpc_prefix}-${var.lb_name}-tg"
 }
}

# Create ALB Listener
resource "aws_lb_listener" "frontend_listener" {
 load_balancer_arn = "${aws_lb.devops-alb.arn}"
 port = "${var.listener_port}"
 protocol = "${var.listener_protocol}"
 ssl_policy = "${var.listener_ssl_policy}"
 certificate_arn = "${var.listener_certificate_arn}"

 default_action {
   type             = "forward"
   target_group_arn = "${aws_lb_target_group.default-http-tg.arn}"
 }
}

