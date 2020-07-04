# Module (WIP)

**07/04/2020**

#### Description

This terraform module is used to create `aws target groups`.

#### Variables

Below are the expected variables by this module.

| Name            | Description                                            |
| --------------- | ------------------------------------------------------ |
|                 |                                                        |
| "tags"
| "vpc_id"
| "tg_name"
| "tg_port"
| "tg_protocol"
| "tg_ip"
| "log_group_name"
| "tg_instanceid"
| "listener_arn" 
| "host_header"
| "healthcheck_path"

#### Output

Below are the expected variables by this module.

| Name                 | Description                  |
| -------------------- | ---------------------------- |
|                      |                              |



#### Usage

Example of calling this module.

```
module "nginx-tg" {
 source = "./modules/service-networking"
 vpc_id = "${aws_vpc.infra-vpc.id}"

 tg_name     = "${var.project}-${var.vpc_prefix}-nginx-tg"
 tg_port     = "80"
 tg_protocol = "HTTP"
 tg_ip       = "instance"
 healthcheck_path = "/"
 listener_arn = "${module.devops-alb.frontend_listener}"
 tg_instanceid ="${module.nginx.instance_id}" 
 host_header  = "nginx.${var.project}.test.com"
 log_group_name = "nginx-alb-log"
 tags = {
    Project = "${var.project}"
  }
}

```

_Refer to `properties file` for the variables._
