# test-tiendanube

##Technical Test

```
DevOps Test

The objetive of this test is to assess your skill level on IaC (Infrastructure as a code) and AWS Cloud knowledges.
The test

You need to create a stack using infrastructure as a code with terraform, and this structure needs to be built into AWS provider using t2.micro instances (aws free tier - we aren'tn responsible for AWS fees), or using yourself criterias over your aws account.
The resources:
1x Application Load Balancer
2x EC2 Server
Server 01 - must have Nginx.
Server 02 - must have Apache.
2x security groups
To ALB
To EC2 instances.
Besides that, all resources involving ALB stack must be created too. Important: All resources need to be created using Terraform.

Deliverable
The terraform script using some repository in github, bitbucket or other.
Terraform output needs to expose ALB address.
Delivery time
5 days. 

How will we evaluate your test?
We will replicate your stack into our testing AWS region.
We will evaluate quaity of your code as well as best practices and organization.
```

## Requirement
* AWS Free Tier Account 
* Jenkins
* Terraform => v0.11
* For Terratest --> Go v0.13

### Constrains
* Replace key_name with your current pem
* Replace Route 53 Azone ID
* Replace Domain Name with your current domain
* Replace SSL arn with current 

## AWS Architecture
![alt text](/images/TiendaNube.png "AWS diagram")

## Jenkins Automation
![alt text](/images/TiendaNube_terratest.png "AWS diagram")

## Terratest
```
------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_default_security_group.terraform-default
      id:                                                <computed>
      arn:                                               <computed>
      description:                                       <computed>
      egress.#:                                          "1"
      egress.482069346.cidr_blocks.#:                    "1"
      egress.482069346.cidr_blocks.0:                    "0.0.0.0/0"
      egress.482069346.description:                      ""
      egress.482069346.from_port:                        "0"
      egress.482069346.ipv6_cidr_blocks.#:               "0"
      egress.482069346.prefix_list_ids.#:                "0"
      egress.482069346.protocol:                         "-1"
      egress.482069346.security_groups.#:                "0"
      egress.482069346.self:                             "false"
      egress.482069346.to_port:                          "0"
      name:                                              <computed>
      owner_id:                                          <computed>
      revoke_rules_on_delete:                            "false"
      tags.%:                                            "1"
      tags.Name:                                         "demo-infra-default-sg"
      vpc_id:                                            "${aws_vpc.infra-vpc.id}"

  + aws_eip.nat_1
      id:                                                <computed>
      allocation_id:                                     <computed>
      association_id:                                    <computed>
      customer_owned_ip:                                 <computed>
      domain:                                            <computed>
      instance:                                          <computed>
      network_interface:                                 <computed>
      private_dns:                                       <computed>
      private_ip:                                        <computed>
      public_dns:                                        <computed>
      public_ip:                                         <computed>
      public_ipv4_pool:                                  <computed>
      vpc:                                               <computed>

  + aws_internet_gateway.default
      id:                                                <computed>
      arn:                                               <computed>
      owner_id:                                          <computed>
      vpc_id:                                            "${aws_vpc.infra-vpc.id}"

  + aws_key_pair.auth_key_pair
      id:                                                <computed>
      arn:                                               <computed>
      fingerprint:                                       <computed>
      key_name:                                          "my-east-1"
      key_pair_id:                                       <computed>
      public_key:                                        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCohXWgFUTuzH1Jmbo+TB+b85kR/7D/0Lvx/m38hNUGPfJRZCvdkAALOgfVnAWt66Q7V1VJ7q9VJhwiDgVjI08qE6FBdOk1mrvyXaqo00zHIRjpZGKcMHZgzDx6n/r89IUKSOr7/ATHNY98xpARB5RKgHyspQlmXzC+tJcRLDzLnTh2Zmu7GQSU+BLmIpTv3/9pzItbgFREw6xhxCg31E+FTGuDDPzW5SXCYiWS8u9XBbmx/asdnU/r0OuOvLeA5gX7YBU/PdCxO8uCoC6C4Fk2t3a6caG60NYuHYUDF5Ou83DHy+m74K2rPFYSbmMWdwiNhjIngUmsMwffBFQu0puX my-east1"

  + aws_nat_gateway.nat_1
      id:                                                <computed>
      allocation_id:                                     "${aws_eip.nat_1.id}"
      network_interface_id:                              <computed>
      private_ip:                                        <computed>
      public_ip:                                         <computed>
      subnet_id:                                         "${aws_subnet.web-az1a-subnet.id}"

  + aws_route.internet_access
      id:                                                <computed>
      destination_cidr_block:                            "0.0.0.0/0"
      destination_prefix_list_id:                        <computed>
      egress_only_gateway_id:                            <computed>
      gateway_id:                                        "${aws_internet_gateway.default.id}"
      instance_id:                                       <computed>
      instance_owner_id:                                 <computed>
      nat_gateway_id:                                    <computed>
      network_interface_id:                              <computed>
      origin:                                            <computed>
      route_table_id:                                    "${aws_vpc.infra-vpc.main_route_table_id}"
      state:                                             <computed>

  + aws_route_table.nat_gw_1
      id:                                                <computed>
      owner_id:                                          <computed>
      propagating_vgws.#:                                <computed>
      route.#:                                           "1"
      route.~3853335770.cidr_block:                      "0.0.0.0/0"
      route.~3853335770.egress_only_gateway_id:          ""
      route.~3853335770.gateway_id:                      ""
      route.~3853335770.instance_id:                     ""
      route.~3853335770.ipv6_cidr_block:                 ""
      route.~3853335770.nat_gateway_id:                  "${aws_nat_gateway.nat_1.id}"
      route.~3853335770.network_interface_id:            ""
      route.~3853335770.transit_gateway_id:              ""
      route.~3853335770.vpc_peering_connection_id:       ""
      tags.%:                                            "1"
      tags.Name:                                         "Application to Internet through Nat #1"
      vpc_id:                                            "${aws_vpc.infra-vpc.id}"

  + aws_route_table_association.app_1_subnet_to_nat_gw
      id:                                                <computed>
      route_table_id:                                    "${aws_route_table.nat_gw_1.id}"
      subnet_id:                                         "${aws_subnet.app-az1a-subnet.id}"

  + aws_route_table_association.app_2_subnet_to_nat_gw
      id:                                                <computed>
      route_table_id:                                    "${aws_route_table.nat_gw_1.id}"
      subnet_id:                                         "${aws_subnet.app-az1b-subnet.id}"

  + aws_subnet.app-az1a-subnet
      id:                                                <computed>
      arn:                                               <computed>
      assign_ipv6_address_on_creation:                   "false"
      availability_zone:                                 "us-east-1a"
      availability_zone_id:                              <computed>
      cidr_block:                                        "10.200.0.64/27"
      ipv6_cidr_block:                                   <computed>
      ipv6_cidr_block_association_id:                    <computed>
      map_public_ip_on_launch:                           "false"
      owner_id:                                          <computed>
      tags.%:                                            "1"
      tags.Name:                                         "demo-infra-app-az1a-subnet"
      vpc_id:                                            "${aws_vpc.infra-vpc.id}"

  + aws_subnet.app-az1b-subnet
      id:                                                <computed>
      arn:                                               <computed>
      assign_ipv6_address_on_creation:                   "false"
      availability_zone:                                 "us-east-1b"
      availability_zone_id:                              <computed>
      cidr_block:                                        "10.200.0.96/27"
      ipv6_cidr_block:                                   <computed>
      ipv6_cidr_block_association_id:                    <computed>
      map_public_ip_on_launch:                           "false"
      owner_id:                                          <computed>
      tags.%:                                            "1"
      tags.Name:                                         "demo-infra-app-az1b-subnet"
      vpc_id:                                            "${aws_vpc.infra-vpc.id}"

  + aws_subnet.web-az1a-subnet
      id:                                                <computed>
      arn:                                               <computed>
      assign_ipv6_address_on_creation:                   "false"
      availability_zone:                                 "us-east-1a"
      availability_zone_id:                              <computed>
      cidr_block:                                        "10.200.0.0/27"
      ipv6_cidr_block:                                   <computed>
      ipv6_cidr_block_association_id:                    <computed>
      map_public_ip_on_launch:                           "true"
      owner_id:                                          <computed>
      tags.%:                                            "1"
      tags.Name:                                         "demo-infra-web-az1a-subnet"
      vpc_id:                                            "${aws_vpc.infra-vpc.id}"

  + aws_subnet.web-az1b-subnet
      id:                                                <computed>
      arn:                                               <computed>
      assign_ipv6_address_on_creation:                   "false"
      availability_zone:                                 "us-east-1b"
      availability_zone_id:                              <computed>
      cidr_block:                                        "10.200.0.32/27"
      ipv6_cidr_block:                                   <computed>
      ipv6_cidr_block_association_id:                    <computed>
      map_public_ip_on_launch:                           "true"
      owner_id:                                          <computed>
      tags.%:                                            "1"
      tags.Name:                                         "demo-infra-web-az1b-subnet"
      vpc_id:                                            "${aws_vpc.infra-vpc.id}"

  + aws_vpc.infra-vpc
      id:                                                <computed>
      arn:                                               <computed>
      assign_generated_ipv6_cidr_block:                  "false"
      cidr_block:                                        "10.200.0.0/16"
      default_network_acl_id:                            <computed>
      default_route_table_id:                            <computed>
      default_security_group_id:                         <computed>
      dhcp_options_id:                                   <computed>
      enable_classiclink:                                <computed>
      enable_classiclink_dns_support:                    <computed>
      enable_dns_hostnames:                              <computed>
      enable_dns_support:                                "true"
      instance_tenancy:                                  "default"
      ipv6_association_id:                               <computed>
      ipv6_cidr_block:                                   <computed>
      main_route_table_id:                               <computed>
      owner_id:                                          <computed>
      tags.%:                                            "1"
      tags.Name:                                         "infra-vpc"

  + module.apache-tg.aws_alb_target_group_attachment.lb_target_group
      id:                                                <computed>
      port:                                              "80"
      target_group_arn:                                  "${aws_lb_target_group.lb_target_group.arn}"
      target_id:                                         "${var.tg_instanceid}"

  + module.apache-tg.aws_cloudwatch_log_group.log-group
      id:                                                <computed>
      arn:                                               <computed>
      name:                                              "apache-alb-log"
      retention_in_days:                                 "0"
      tags.%:                                            "1"
      tags.Project:                                      "demo"

  + module.apache-tg.aws_lb_listener_rule.host_based_routing
      id:                                                <computed>
      action.#:                                          "1"
      action.0.order:                                    <computed>
      action.0.target_group_arn:                         "${aws_lb_target_group.lb_target_group.arn}"
      action.0.type:                                     "forward"
      arn:                                               <computed>
      condition.#:                                       "1"
      condition.2856818356.field:                        "host-header"
      condition.2856818356.host_header.#:                <computed>
      condition.2856818356.http_header.#:                "0"
      condition.2856818356.http_request_method.#:        "0"
      condition.2856818356.path_pattern.#:               <computed>
      condition.2856818356.query_string.#:               "0"
      condition.2856818356.source_ip.#:                  "0"
      condition.2856818356.values.#:                     "1"
      condition.2856818356.values.0:                     "apache.demo.test.com"
      listener_arn:                                      "${var.listener_arn}"
      priority:                                          <computed>

  + module.apache-tg.aws_lb_target_group.lb_target_group
      id:                                                <computed>
      arn:                                               <computed>
      arn_suffix:                                        <computed>
      deregistration_delay:                              "30"
      health_check.#:                                    "1"
      health_check.0.enabled:                            "true"
      health_check.0.healthy_threshold:                  "2"
      health_check.0.interval:                           "30"
      health_check.0.matcher:                            "200,302"
      health_check.0.path:                               "/"
      health_check.0.port:                               "traffic-port"
      health_check.0.protocol:                           "HTTP"
      health_check.0.timeout:                            <computed>
      health_check.0.unhealthy_threshold:                "4"
      lambda_multi_value_headers_enabled:                "false"
      load_balancing_algorithm_type:                     <computed>
      name:                                              "demo-infra-apache-tg"
      port:                                              "80"
      protocol:                                          "HTTP"
      proxy_protocol_v2:                                 "false"
      slow_start:                                        "0"
      stickiness.#:                                      <computed>
      target_type:                                       "instance"
      vpc_id:                                            "${var.vpc_id}"

  + module.apache.aws_instance.ec2
      id:                                                <computed>
      ami:                                               "ami-c998b6b2"
      arn:                                               <computed>
      associate_public_ip_address:                       "false"
      availability_zone:                                 <computed>
      cpu_core_count:                                    <computed>
      cpu_threads_per_core:                              <computed>
      ebs_block_device.#:                                "1"
      ebs_block_device.2576023345.delete_on_termination: "true"
      ebs_block_device.2576023345.device_name:           "/dev/sdb"
      ebs_block_device.2576023345.encrypted:             "true"
      ebs_block_device.2576023345.iops:                  ""
      ebs_block_device.2576023345.kms_key_id:            <computed>
      ebs_block_device.2576023345.snapshot_id:           <computed>
      ebs_block_device.2576023345.volume_id:             <computed>
      ebs_block_device.2576023345.volume_size:           "50"
      ebs_block_device.2576023345.volume_type:           "gp2"
      ephemeral_block_device.#:                          <computed>
      get_password_data:                                 "false"
      host_id:                                           <computed>
      instance_state:                                    <computed>
      instance_type:                                     "t2.micro"
      ipv6_address_count:                                <computed>
      ipv6_addresses.#:                                  <computed>
      key_name:                                          "${var.key_name}"
      metadata_options.#:                                <computed>
      network_interface.#:                               <computed>
      network_interface_id:                              <computed>
      outpost_arn:                                       <computed>
      password_data:                                     <computed>
      placement_group:                                   <computed>
      primary_network_interface_id:                      <computed>
      private_dns:                                       <computed>
      private_ip:                                        <computed>
      public_dns:                                        <computed>
      public_ip:                                         <computed>
      root_block_device.#:                               <computed>
      security_groups.#:                                 <computed>
      source_dest_check:                                 "true"
      subnet_id:                                         "${var.subnet_id}"
      tags.%:                                            "1"
      tags.Name:                                         "demo-infra-sonarqube"
      tenancy:                                           <computed>
      volume_tags.%:                                     <computed>
      vpc_security_group_ids.#:                          <computed>

  + module.apache.aws_security_group.ec2-sg
      id:                                                <computed>
      arn:                                               <computed>
      description:                                       "sonarqube security group"
      egress.#:                                          "1"
      egress.482069346.cidr_blocks.#:                    "1"
      egress.482069346.cidr_blocks.0:                    "0.0.0.0/0"
      egress.482069346.description:                      ""
      egress.482069346.from_port:                        "0"
      egress.482069346.ipv6_cidr_blocks.#:               "0"
      egress.482069346.prefix_list_ids.#:                "0"
      egress.482069346.protocol:                         "-1"
      egress.482069346.security_groups.#:                "0"
      egress.482069346.self:                             "false"
      egress.482069346.to_port:                          "0"
      ingress.#:                                         "1"
      ingress.2510676008.cidr_blocks.#:                  "1"
      ingress.2510676008.cidr_blocks.0:                  "0.0.0.0/0"
      ingress.2510676008.description:                    ""
      ingress.2510676008.from_port:                      "0"
      ingress.2510676008.ipv6_cidr_blocks.#:             "0"
      ingress.2510676008.prefix_list_ids.#:              "0"
      ingress.2510676008.protocol:                       "-1"
      ingress.2510676008.security_groups.#:              "0"
      ingress.2510676008.self:                           "true"
      ingress.2510676008.to_port:                        "0"
      name:                                              "sonarqube-sg"
      owner_id:                                          <computed>
      revoke_rules_on_delete:                            "false"
      tags.%:                                            "1"
      tags.Name:                                         "demo-infra-sonarqube-sg"
      vpc_id:                                            "${var.vpc_id}"

  + module.bastion.aws_instance.ec2
      id:                                                <computed>
      ami:                                               "ami-c998b6b2"
      arn:                                               <computed>
      associate_public_ip_address:                       "true"
      availability_zone:                                 <computed>
      cpu_core_count:                                    <computed>
      cpu_threads_per_core:                              <computed>
      ebs_block_device.#:                                "1"
      ebs_block_device.2576023345.delete_on_termination: "true"
      ebs_block_device.2576023345.device_name:           "/dev/sdb"
      ebs_block_device.2576023345.encrypted:             "true"
      ebs_block_device.2576023345.iops:                  ""
      ebs_block_device.2576023345.kms_key_id:            <computed>
      ebs_block_device.2576023345.snapshot_id:           <computed>
      ebs_block_device.2576023345.volume_id:             <computed>
      ebs_block_device.2576023345.volume_size:           "50"
      ebs_block_device.2576023345.volume_type:           "gp2"
      ephemeral_block_device.#:                          <computed>
      get_password_data:                                 "false"
      host_id:                                           <computed>
      instance_state:                                    <computed>
      instance_type:                                     "t2.micro"
      ipv6_address_count:                                <computed>
      ipv6_addresses.#:                                  <computed>
      key_name:                                          "${var.key_name}"
      metadata_options.#:                                <computed>
      network_interface.#:                               <computed>
      network_interface_id:                              <computed>
      outpost_arn:                                       <computed>
      password_data:                                     <computed>
      placement_group:                                   <computed>
      primary_network_interface_id:                      <computed>
      private_dns:                                       <computed>
      private_ip:                                        <computed>
      public_dns:                                        <computed>
      public_ip:                                         <computed>
      root_block_device.#:                               <computed>
      security_groups.#:                                 <computed>
      source_dest_check:                                 "true"
      subnet_id:                                         "${var.subnet_id}"
      tags.%:                                            "1"
      tags.Name:                                         "demo-infra-bastion"
      tenancy:                                           <computed>
      volume_tags.%:                                     <computed>
      vpc_security_group_ids.#:                          <computed>

  + module.bastion.aws_security_group.ec2-sg
      id:                                                <computed>
      arn:                                               <computed>
      description:                                       "bastion security group"
      egress.#:                                          "1"
      egress.482069346.cidr_blocks.#:                    "1"
      egress.482069346.cidr_blocks.0:                    "0.0.0.0/0"
      egress.482069346.description:                      ""
      egress.482069346.from_port:                        "0"
      egress.482069346.ipv6_cidr_blocks.#:               "0"
      egress.482069346.prefix_list_ids.#:                "0"
      egress.482069346.protocol:                         "-1"
      egress.482069346.security_groups.#:                "0"
      egress.482069346.self:                             "false"
      egress.482069346.to_port:                          "0"
      ingress.#:                                         "1"
      ingress.2510676008.cidr_blocks.#:                  "1"
      ingress.2510676008.cidr_blocks.0:                  "0.0.0.0/0"
      ingress.2510676008.description:                    ""
      ingress.2510676008.from_port:                      "0"
      ingress.2510676008.ipv6_cidr_blocks.#:             "0"
      ingress.2510676008.prefix_list_ids.#:              "0"
      ingress.2510676008.protocol:                       "-1"
      ingress.2510676008.security_groups.#:              "0"
      ingress.2510676008.self:                           "true"
      ingress.2510676008.to_port:                        "0"
      name:                                              "bastion-sg"
      owner_id:                                          <computed>
      revoke_rules_on_delete:                            "false"
      tags.%:                                            "1"
      tags.Name:                                         "demo-infra-bastion-sg"
      vpc_id:                                            "${var.vpc_id}"

  + module.devops-alb.aws_lb.devops-alb
      id:                                                <computed>
      arn:                                               <computed>
      arn_suffix:                                        <computed>
      dns_name:                                          <computed>
      drop_invalid_header_fields:                        "false"
      enable_deletion_protection:                        "false"
      enable_http2:                                      "true"
      idle_timeout:                                      "60"
      internal:                                          "false"
      ip_address_type:                                   <computed>
      load_balancer_type:                                "application"
      name:                                              "devops-alb"
      security_groups.#:                                 <computed>
      subnet_mapping.#:                                  <computed>
      subnets.#:                                         <computed>
      tags.%:                                            "2"
      tags.Name:                                         "devops-alb"
      tags.Project:                                      "demo"
      vpc_id:                                            <computed>
      zone_id:                                           <computed>

  + module.devops-alb.aws_lb_listener.frontend_listener
      id:                                                <computed>
      arn:                                               <computed>
      certificate_arn:                                   "arn:aws:acm:us-east-1:1234:certificate/1234"
      default_action.#:                                  "1"
      default_action.0.order:                            <computed>
      default_action.0.target_group_arn:                 "${aws_lb_target_group.default-http-tg.arn}"
      default_action.0.type:                             "forward"
      load_balancer_arn:                                 "${aws_lb.devops-alb.arn}"
      port:                                              "443"
      protocol:                                          "HTTPS"
      ssl_policy:                                        "ELBSecurityPolicy-2016-08"

  + module.devops-alb.aws_lb_target_group.default-http-tg
      id:                                                <computed>
      arn:                                               <computed>
      arn_suffix:                                        <computed>
      deregistration_delay:                              "300"
      health_check.#:                                    "1"
      health_check.0.enabled:                            "true"
      health_check.0.healthy_threshold:                  "2"
      health_check.0.interval:                           "30"
      health_check.0.matcher:                            <computed>
      health_check.0.path:                               <computed>
      health_check.0.port:                               "traffic-port"
      health_check.0.protocol:                           "HTTP"
      health_check.0.timeout:                            <computed>
      health_check.0.unhealthy_threshold:                "2"
      lambda_multi_value_headers_enabled:                "false"
      load_balancing_algorithm_type:                     <computed>
      name:                                              "default-http-tg"
      port:                                              "8081"
      protocol:                                          "HTTP"
      proxy_protocol_v2:                                 "false"
      slow_start:                                        "0"
      stickiness.#:                                      <computed>
      tags.%:                                            "1"
      tags.Name:                                         "demo-infra-devops-alb-tg"
      target_type:                                       "instance"
      vpc_id:                                            "${var.vpc_id}"

  + module.devops-alb.aws_route53_record.devops-alb
      id:                                                <computed>
      alias.#:                                           "1"
      alias.~2894399171.evaluate_target_health:          "true"
      alias.~2894399171.name:                            "${aws_lb.devops-alb.dns_name}"
      alias.~2894399171.zone_id:                         "${aws_lb.devops-alb.zone_id}"
      allow_overwrite:                                   <computed>
      fqdn:                                              <computed>
      name:                                              "*.demo.test.com"
      type:                                              "A"
      zone_id:                                           "Z272L6V00A99RH"

  + module.devops-alb.aws_security_group.web_alb_sg
      id:                                                <computed>
      arn:                                               <computed>
      description:                                       "Used in the terraform"
      egress.#:                                          "1"
      egress.482069346.cidr_blocks.#:                    "1"
      egress.482069346.cidr_blocks.0:                    "0.0.0.0/0"
      egress.482069346.description:                      ""
      egress.482069346.from_port:                        "0"
      egress.482069346.ipv6_cidr_blocks.#:               "0"
      egress.482069346.prefix_list_ids.#:                "0"
      egress.482069346.protocol:                         "-1"
      egress.482069346.security_groups.#:                "0"
      egress.482069346.self:                             "false"
      egress.482069346.to_port:                          "0"
      ingress.#:                                         "1"
      ingress.2617001939.cidr_blocks.#:                  "1"
      ingress.2617001939.cidr_blocks.0:                  "0.0.0.0/0"
      ingress.2617001939.description:                    ""
      ingress.2617001939.from_port:                      "443"
      ingress.2617001939.ipv6_cidr_blocks.#:             "0"
      ingress.2617001939.prefix_list_ids.#:              "0"
      ingress.2617001939.protocol:                       "tcp"
      ingress.2617001939.security_groups.#:              "0"
      ingress.2617001939.self:                           "false"
      ingress.2617001939.to_port:                        "443"
      name:                                              "terraform_example"
      owner_id:                                          <computed>
      revoke_rules_on_delete:                            "false"
      tags.%:                                            "1"
      tags.Name:                                         "demo-infra-web-alb-sg"
      vpc_id:                                            "${var.vpc_id}"

  + module.nginx-tg.aws_alb_target_group_attachment.lb_target_group
      id:                                                <computed>
      port:                                              "80"
      target_group_arn:                                  "${aws_lb_target_group.lb_target_group.arn}"
      target_id:                                         "${var.tg_instanceid}"

  + module.nginx-tg.aws_cloudwatch_log_group.log-group
      id:                                                <computed>
      arn:                                               <computed>
      name:                                              "nginx-alb-log"
      retention_in_days:                                 "0"
      tags.%:                                            "1"
      tags.Project:                                      "demo"

  + module.nginx-tg.aws_lb_listener_rule.host_based_routing
      id:                                                <computed>
      action.#:                                          "1"
      action.0.order:                                    <computed>
      action.0.target_group_arn:                         "${aws_lb_target_group.lb_target_group.arn}"
      action.0.type:                                     "forward"
      arn:                                               <computed>
      condition.#:                                       "1"
      condition.3923709093.field:                        "host-header"
      condition.3923709093.host_header.#:                <computed>
      condition.3923709093.http_header.#:                "0"
      condition.3923709093.http_request_method.#:        "0"
      condition.3923709093.path_pattern.#:               <computed>
      condition.3923709093.query_string.#:               "0"
      condition.3923709093.source_ip.#:                  "0"
      condition.3923709093.values.#:                     "1"
      condition.3923709093.values.0:                     "nginx.demo.test.com"
      listener_arn:                                      "${var.listener_arn}"
      priority:                                          <computed>

  + module.nginx-tg.aws_lb_target_group.lb_target_group
      id:                                                <computed>
      arn:                                               <computed>
      arn_suffix:                                        <computed>
      deregistration_delay:                              "30"
      health_check.#:                                    "1"
      health_check.0.enabled:                            "true"
      health_check.0.healthy_threshold:                  "2"
      health_check.0.interval:                           "30"
      health_check.0.matcher:                            "200,302"
      health_check.0.path:                               "/"
      health_check.0.port:                               "traffic-port"
      health_check.0.protocol:                           "HTTP"
      health_check.0.timeout:                            <computed>
      health_check.0.unhealthy_threshold:                "4"
      lambda_multi_value_headers_enabled:                "false"
      load_balancing_algorithm_type:                     <computed>
      name:                                              "demo-infra-nginx-tg"
      port:                                              "80"
      protocol:                                          "HTTP"
      proxy_protocol_v2:                                 "false"
      slow_start:                                        "0"
      stickiness.#:                                      <computed>
      target_type:                                       "instance"
      vpc_id:                                            "${var.vpc_id}"

  + module.nginx.aws_instance.ec2
      id:                                                <computed>
      ami:                                               "ami-c998b6b2"
      arn:                                               <computed>
      associate_public_ip_address:                       "false"
      availability_zone:                                 <computed>
      cpu_core_count:                                    <computed>
      cpu_threads_per_core:                              <computed>
      ebs_block_device.#:                                "1"
      ebs_block_device.2576023345.delete_on_termination: "true"
      ebs_block_device.2576023345.device_name:           "/dev/sdb"
      ebs_block_device.2576023345.encrypted:             "true"
      ebs_block_device.2576023345.iops:                  ""
      ebs_block_device.2576023345.kms_key_id:            <computed>
      ebs_block_device.2576023345.snapshot_id:           <computed>
      ebs_block_device.2576023345.volume_id:             <computed>
      ebs_block_device.2576023345.volume_size:           "50"
      ebs_block_device.2576023345.volume_type:           "gp2"
      ephemeral_block_device.#:                          <computed>
      get_password_data:                                 "false"
      host_id:                                           <computed>
      instance_state:                                    <computed>
      instance_type:                                     "t2.micro"
      ipv6_address_count:                                <computed>
      ipv6_addresses.#:                                  <computed>
      key_name:                                          "${var.key_name}"
      metadata_options.#:                                <computed>
      network_interface.#:                               <computed>
      network_interface_id:                              <computed>
      outpost_arn:                                       <computed>
      password_data:                                     <computed>
      placement_group:                                   <computed>
      primary_network_interface_id:                      <computed>
      private_dns:                                       <computed>
      private_ip:                                        <computed>
      public_dns:                                        <computed>
      public_ip:                                         <computed>
      root_block_device.#:                               <computed>
      security_groups.#:                                 <computed>
      source_dest_check:                                 "true"
      subnet_id:                                         "${var.subnet_id}"
      tags.%:                                            "1"
      tags.Name:                                         "demo-infra-nginx"
      tenancy:                                           <computed>
      volume_tags.%:                                     <computed>
      vpc_security_group_ids.#:                          <computed>

  + module.nginx.aws_security_group.ec2-sg
      id:                                                <computed>
      arn:                                               <computed>
      description:                                       "nginx security group"
      egress.#:                                          "1"
      egress.482069346.cidr_blocks.#:                    "1"
      egress.482069346.cidr_blocks.0:                    "0.0.0.0/0"
      egress.482069346.description:                      ""
      egress.482069346.from_port:                        "0"
      egress.482069346.ipv6_cidr_blocks.#:               "0"
      egress.482069346.prefix_list_ids.#:                "0"
      egress.482069346.protocol:                         "-1"
      egress.482069346.security_groups.#:                "0"
      egress.482069346.self:                             "false"
      egress.482069346.to_port:                          "0"
      ingress.#:                                         "1"
      ingress.2510676008.cidr_blocks.#:                  "1"
      ingress.2510676008.cidr_blocks.0:                  "0.0.0.0/0"
      ingress.2510676008.description:                    ""
      ingress.2510676008.from_port:                      "0"
      ingress.2510676008.ipv6_cidr_blocks.#:             "0"
      ingress.2510676008.prefix_list_ids.#:              "0"
      ingress.2510676008.protocol:                       "-1"
      ingress.2510676008.security_groups.#:              "0"
      ingress.2510676008.self:                           "true"
      ingress.2510676008.to_port:                        "0"
      name:                                              "nginx-sg"
      owner_id:                                          <computed>
      revoke_rules_on_delete:                            "false"
      tags.%:                                            "1"
      tags.Name:                                         "demo-infra-nginx-sg"
      vpc_id:                                            "${var.vpc_id}"

  + module.whitelist-sg.aws_security_group.whitelist-sg
      id:                                                <computed>
      arn:                                               <computed>
      description:                                       "whitelist security group"
      egress.#:                                          <computed>
      ingress.#:                                         "1"
      ingress.2510676008.cidr_blocks.#:                  "1"
      ingress.2510676008.cidr_blocks.0:                  "0.0.0.0/0"
      ingress.2510676008.description:                    ""
      ingress.2510676008.from_port:                      "0"
      ingress.2510676008.ipv6_cidr_blocks.#:             "0"
      ingress.2510676008.prefix_list_ids.#:              "0"
      ingress.2510676008.protocol:                       "-1"
      ingress.2510676008.security_groups.#:              "0"
      ingress.2510676008.self:                           "true"
      ingress.2510676008.to_port:                        "0"
      name:                                              "whitelist-sg"
      owner_id:                                          <computed>
      revoke_rules_on_delete:                            "false"
      tags.%:                                            "1"
      tags.Name:                                         "demo-infra-whitelist-sg"
      vpc_id:                                            "${var.vpc_id}"


Plan: 34 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.


```
