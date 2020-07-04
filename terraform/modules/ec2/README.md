# Module (WIP)

**07/04/2020**

#### Description

This terraform module is used to create `aws ec2`.

#### Variables

Below are the expected variables by this module.

| Name            | Description                                            |
| --------------- | ------------------------------------------------------ |
|                 |                                                        |
| "public_key"
| "private_key_path"
| "key_name"
| "aws_region"
| "vpc_id"
| "subnet_id"
| "aws_amis"
| "sg_id"
| "vpc_name"
| "vpc_prefix"
| "project"
| "service_name"
| "aws_instance_type"
| "ami_id"
| "run_list"
| "bastion_user"
| "bastion_ip"

#### Output

Below are the expected variables by this module.

| Name                 | Description                  |
| -------------------- | ---------------------------- |
|                      |                              |
| "private_ip"
| "instance_id"



#### Usage

Example of calling this module.

```
module "nginx" {
 source = "./modules/ec2"
 service_name = "nginx"
 vpc_id = "${aws_vpc.infra-vpc.id}"
 subnet_id = "${aws_subnet.app-az1a-subnet.id}"
 sg_id = "${module.whitelist-sg.sg_id}"
 private_key_path = "${var.private_key_path}"
 aws_instance_type = "${var.aws_instance_type}"
 ami_id = "${var.ami_id}"
 project = "${var.project}"
 vpc_prefix = "${var.vpc_prefix}"
 run_list = "${var.run_list_nginx}"
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

```

_Refer to `properties file` for the variables._
