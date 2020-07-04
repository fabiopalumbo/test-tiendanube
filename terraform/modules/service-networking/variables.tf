variable "tags" { type = "map" }

variable "vpc_id" {}

# LB Target Group
variable "tg_name" {}
variable "tg_port" {}
variable "tg_protocol" {}
variable "tg_ip" {}

# Log Group
variable "log_group_name" {}

# LB Target_id 
variable "tg_instanceid" {} 

variable "listener_arn" {}
variable "host_header" {}
variable "healthcheck_path" {}
