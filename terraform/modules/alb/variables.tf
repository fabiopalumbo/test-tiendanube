variable "vpc_id" {}

# LB
variable "lb_name" {}
variable "lb_security_groups" {}
variable "lb_subnets" { type = "list"}

# LB Listener
variable "listener_port" {}
variable "listener_protocol" {}
variable "listener_ssl_policy" {}
variable "listener_certificate_arn" {}
variable "front_end_client_listener_certificate_arn" {}
variable "vpc_name" {}
variable "vpc_prefix" {}
variable "project" {}
variable "tags" {type = "map"}

#R53 for LB

variable "r53_zoneid" {default = "Z272L6V00A99RH" } 
