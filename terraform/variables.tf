variable "public_key" {
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCohXWgFUTuzH1Jmbo+TB+b85kR/7D/0Lvx/m38hNUGPfJRZCvdkAALOgfVnAWt66Q7V1VJ7q9VJhwiDgVjI08qE6FBdOk1mrvyXaqo00zHIRjpZGKcMHZgzDx6n/r89IUKSOr7/ATHNY98xpARB5RKgHyspQlmXzC+tJcRLDzLnTh2Zmu7GQSU+BLmIpTv3/9pzItbgFREw6xhxCg31E+FTGuDDPzW5SXCYiWS8u9XBbmx/asdnU/r0OuOvLeA5gX7YBU/PdCxO8uCoC6C4Fk2t3a6caG60NYuHYUDF5Ou83DHy+m74K2rPFYSbmMWdwiNhjIngUmsMwffBFQu0puX my-east1"
  description = ""
}

variable "key_name" {
  default = "my-east-1"
}  

variable "aws_region" {
  default = "us-east-1"
  description = ""
}

variable "az_suffix_1" {
  default = "a"
  description = ""
}

variable "az_suffix_2" {
  default = "b"
  description = ""
}

variable "aws_vpc_cidr" {
  description 	= "aws vpc cidr"
  default	= "10.200.0.0/16"
}

variable "web-az1a-subnet-cidr" {
  description   = "web-az1a-subnet-cidr"
  default       = "10.200.0.0/27"
}

variable "web-az1b-subnet-cidr" {
  description   = "web-az1b-subnet-cidr"
  default       = "10.200.0.32/27"
}

variable "app-az1a-subnet-cidr" {
  description   = "web-az1a-subnet-cidr"
  default       = "10.200.0.64/27"
}

variable "app-az1b-subnet-cidr" {
  description   = "web-az1b-subnet-cidr"
  default       = "10.200.0.96/27"
}

variable "web-alb-name" {
  description   = "web-alb-name"
  default       = "devops-alb"
}

variable "front_end_client_listener_certificate_arn" {
 default       = "arn:aws:acm:us-east-1:1234:certificate/1234"
}

# Ubuntu Precise 12.04 LTS (x64)
variable "aws_amis" {
  default = {
    eu-west-1 = "ami-674cbc1e"
    us-east-1 = "ami-c998b6b2"
    us-west-1 = "ami-969ab1f6"
    us-west-2 = "ami-8803e0f0"
  }
}

variable "vpc_name" {
  default = "infra-vpc"
  description = ""
}

variable "vpc_prefix" {
  default = "infra"
  description = ""
}
variable "project" {
  default = "demo"
}

variable "private_key_path" {
  default = "~/.ssh/my-east1.pem"
  description = ""
}

variable "aws_instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  default = "ami-c998b6b2"
  description = ""
}

variable "lb_name" {
  default = "devops-alb"
}

variable "run_list_bastion" {
  default = "sleep 60; "
}

variable "run_list_nginx" {
  default = "sleep 60; sudo yum install -y epel-release; sudo yum install -y nginx; sudo systemctl enable nginx; sudo systemctl start nginx"
}

variable "run_list_apache" {
  default = "sleep 60; sudo yum install -y httpd; sudo systemctl enable httpd; sudo systemctl start httpd"
}
