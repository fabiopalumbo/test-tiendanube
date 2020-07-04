# Specify the provider and access details

provider "aws" {
  version = ">= 2.18"
  region = "${var.aws_region}"
}


# Create a VPC to launch our instances into
resource "aws_vpc" "infra-vpc" {
  cidr_block = "${var.aws_vpc_cidr}"

  tags = {
    Name = "${var.vpc_name}"
  }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.infra-vpc.id}"
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.infra-vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

# Create Subnets
#################################################################
resource "aws_subnet" "web-az1a-subnet" {
  vpc_id                  = "${aws_vpc.infra-vpc.id}"
  cidr_block              = "${var.web-az1a-subnet-cidr}"
  availability_zone	  = "${var.aws_region}${var.az_suffix_1}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-${var.vpc_prefix}-web-az1${var.az_suffix_1}-subnet"
  }
}

resource "aws_subnet" "web-az1b-subnet" {
  vpc_id                  = "${aws_vpc.infra-vpc.id}"
  cidr_block              = "${var.web-az1b-subnet-cidr}"
  availability_zone       = "${var.aws_region}${var.az_suffix_2}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-${var.vpc_prefix}-web-az1${var.az_suffix_2}-subnet"
  }
}

resource "aws_subnet" "app-az1a-subnet" {
  vpc_id                  = "${aws_vpc.infra-vpc.id}"
  cidr_block              = "${var.app-az1a-subnet-cidr}"
  availability_zone       = "${var.aws_region}${var.az_suffix_1}"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project}-${var.vpc_prefix}-app-az1${var.az_suffix_1}-subnet"
  }
}

resource "aws_subnet" "app-az1b-subnet" {
  vpc_id                  = "${aws_vpc.infra-vpc.id}"
  cidr_block              = "${var.app-az1b-subnet-cidr}"
  availability_zone       = "${var.aws_region}${var.az_suffix_2}"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project}-${var.vpc_prefix}-app-az1${var.az_suffix_2}-subnet"
  }
}

# Nat gateway #1
resource "aws_eip" "nat_1" {
}

resource "aws_nat_gateway" "nat_1" {
  allocation_id = "${aws_eip.nat_1.id}"
  subnet_id = "${aws_subnet.web-az1a-subnet.id}"
  depends_on = ["aws_internet_gateway.default"]
}

resource "aws_route_table" "nat_gw_1" {
  vpc_id = "${aws_vpc.infra-vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_1.id}"
  }

  tags {
    Name = "Application to Internet through Nat #1"
  }
}

resource "aws_route_table_association" "app_1_subnet_to_nat_gw" {
  route_table_id = "${aws_route_table.nat_gw_1.id}"
  subnet_id      = "${aws_subnet.app-az1a-subnet.id}"
}

resource "aws_route_table_association" "app_2_subnet_to_nat_gw" {
  route_table_id = "${aws_route_table.nat_gw_1.id}"
  subnet_id      = "${aws_subnet.app-az1b-subnet.id}"
}

# Security Groups
##################################################################
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


# AWS KEY PAIR
###################################################################
resource "aws_key_pair" "auth_key_pair" {
  key_name   = "${var.key_name}"
  public_key = "${var.public_key}"
}

# EC2
###################################################################
module "bastion" {
 source = "./modules/bastion"
 service_name = "bastion"
 vpc_id = "${aws_vpc.infra-vpc.id}"
 subnet_id = "${aws_subnet.web-az1a-subnet.id}"
 sg_id = "${module.whitelist-sg.sg_id}"
 private_key_path = "${var.private_key_path}"
 aws_instance_type = "${var.aws_instance_type}"
 ami_id = "${var.ami_id}"
 project = "${var.project}"
 vpc_prefix = "${var.vpc_prefix}"
 run_list = "${var.run_list}"
 key_name = "${aws_key_pair.auth_key_pair.id}"
 aws_amis = "${var.aws_amis}"
 vpc_name = "${var.vpc_name}"
 public_key = "${var.public_key}"
 aws_region = "${var.aws_region}"
}

module "nginx" {
 source = "./modules/ec2"
 service_name = "nginx"
 vpc_id = "${aws_vpc.infra-vpc.id}"
 subnet_id = "${aws_subnet.app-az1a-subnet.id}"
 sg_id = "${module.whitelist-sg.sg_id}"
 private_key_path = "${var.private_key_path}"
 aws_instance_type = "t3.large"
 ami_id = "${var.ami_id}"
 project = "${var.project}"
 vpc_prefix = "${var.vpc_prefix}"
 run_list = "${var.run_list}"
 key_name = "${aws_key_pair.auth_key_pair.id}"
 aws_region = "${var.aws_region}" 
 aws_amis = "${var.aws_amis}"
 vpc_name = "${var.vpc_name}"
 public_key = "${var.public_key}"
 #chef_key = "${var.chef_key}"
 #chef_user = "${var.chef_user}"
 #chef_environment = "${var.chef_environment}" 
 #chef_server_url = "${var.chef_server_url}"
 bastion_ip = "${module.bastion.bastion_public_ip}"
}

module "apache" {
 source = "./modules/ec2"
 service_name = "sonarqube"
 vpc_id = "${aws_vpc.infra-vpc.id}"
 subnet_id = "${aws_subnet.app-az1a-subnet.id}"
 sg_id = "${module.whitelist-sg.sg_id}"
 private_key_path = "${var.private_key_path}"
 aws_instance_type = "t3.large"
 ami_id = "${var.ami_id}"
 project = "${var.project}"
 vpc_prefix = "${var.vpc_prefix}"
 run_list = "${var.run_list}"
 key_name = "${aws_key_pair.auth_key_pair.id}"
 aws_amis = "${var.aws_amis}"
 vpc_name = "${var.vpc_name}"
 public_key = "${var.public_key}"
 aws_region = "${var.aws_region}"
 #chef_key = "${var.chef_key}"
 #chef_user = "${var.chef_user}"
 #chef_environment = "${var.chef_environment}" 
 #chef_server_url = "${var.chef_server_url}"
 bastion_ip = "${module.bastion.bastion_public_ip}"
}



#ALB
###################################################################
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

# Target Groups
###################################################################
module "nginx-tg" {
 source = "./modules/service-networking"
 vpc_id = "${aws_vpc.infra-vpc.id}"

 tg_name     = "${var.project}-${var.vpc_prefix}-nginx-tg"
 tg_port     = "8081"
 tg_protocol = "HTTP"
 tg_ip       = "instance"
 healthcheck_path = "/nexus"
 listener_arn = "${module.devops-alb.frontend_listener}"
 tg_instanceid ="${module.nexus.instance_id}" 
 host_header  = "nginx.${var.project}.test.com"
 log_group_name = "nginx-alb-log"
 tags = {
    Project = "${var.project}"
  }
}

module "apache-tg" {
 source = "./modules/service-networking"
 vpc_id = "${aws_vpc.infra-vpc.id}"

 tg_name     = "${var.project}-${var.vpc_prefix}-apache-tg"
 tg_port     = "8080"
 tg_protocol = "HTTP"
 tg_ip       = "instance"
 healthcheck_path = "/"
 listener_arn = "${module.devops-alb.frontend_listener}"
 tg_instanceid ="${module.apache.instance_id}"
 host_header  = "apache.${var.project}.test.com"
 log_group_name = "apache-alb-log"
 tags = {
    Project = "${var.project}"
  }
}

