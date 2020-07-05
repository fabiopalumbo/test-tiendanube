resource "aws_security_group" "whitelist-sg" {
  name        = "whitelist-sg"
  description = "whitelist security group"
  vpc_id      = var.vpc_id

  ingress {
    protocol    = -1
    self        = true
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-${var.vpc_prefix}-whitelist-sg"
  }
}

output "sg_id" {
  value = aws_security_group.whitelist-sg.id
}

