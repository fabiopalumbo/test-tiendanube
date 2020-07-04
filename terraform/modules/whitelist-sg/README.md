# Module (WIP)

**07/04/2020**

#### Description

This terraform module is used to create `aws whitelist sg`.

#### Variables

Below are the expected variables by this module.

| Name            | Description                                            |
| --------------- | ------------------------------------------------------ |
|                 |                                                        |
| "vpc_id"
| "vpc_prefix"
| "project" 

#### Output

Below are the expected variables by this module.

| Name                 | Description                  |
| -------------------- | ---------------------------- |
|                      |                              |




#### Usage

Example of calling this module.

```
resource "aws_default_security_group" "terraform-default" {
  vpc_id = "${aws_vpc.infra-vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.project}-${var.vpc_prefix}-default-sg" }
}


module "whitelist-sg" {
 source = "./modules/whitelist-sg"
 vpc_id = "${aws_vpc.infra-vpc.id}"
 project = "${var.project}"
 vpc_prefix = "${var.vpc_prefix}"
}

```

_Refer to `properties file` for the variables._
