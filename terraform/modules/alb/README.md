# Module (WIP)

**07/04/2020**

#### Description

This terraform module is used to create `aws alb`.

#### Variables

Below are the expected variables by this module.

| Name            | Description                                            |
| --------------- | ------------------------------------------------------ |
|                 |                                                        |
| vpc_id          |                                                        |
| lb_name         |                                                        |
| lb_security_groups|                                                      |
| lb_subnets      |                                                        |
| listener_port   |                                                        |
| listener_protocol|                                                       |
| listener_ssl_policy|                                                     |
| listener_certificate_arn|                                                |
| front_end_client_listener_certificate_arn|                               |
| vpc_name        |                                                        |
| vpc_prefix      |                                                        |
| project         |                                                        |
| tags            |                                                        |
| r53_zoneid      |                                                        |


#### Output

Below are the expected variables by this module.

| Name                 | Description                  |
| -------------------- | ---------------------------- |
|                      |                              |
| address              |                              |
| frontend_listener    |                              |
 



#### Usage

Example of calling this module.

```
module "devops-alb" {
 source = "./modules/alb"
 vpc_id = "${aws_vpc.infra-vpc.id}"
 vpc_prefix = "${var.vpc_prefix}"
 vpc_name = "${var.vpc_name}"
 project = "${var.project}"
 front_end_client_listener_certificate_arn = "${var.front_end_client_listener_certificate_arn}"

 lb_name            = "${var.web-alb-name}"
 lb_security_groups = [""]
 lb_subnets         = ["${aws_subnet.web-az1a-subnet.id}", "${aws_subnet.web-az1b-subnet.id}"]

 listener_port            = "443"
 listener_protocol        = "HTTPS"
 listener_ssl_policy      = "ELBSecurityPolicy-2016-08"
 listener_certificate_arn = "${var.front_end_client_listener_certificate_arn}"
 tags = {
     Name = "devops-alb"
     Project = "${var.project}"
  }

}
```

_Refer to `properties file` for the variables._
