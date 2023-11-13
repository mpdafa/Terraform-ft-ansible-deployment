

terraform state list

terraform show

terraform state show aws_vpc.our_vpc
-> resource "aws_vpc" "our_vpc" {
    arn                                  = "arn:aws:ec2:us-east-1:113296392243:vpc/vpc-0968cbac5f4fb1eb0"
    assign_generated_ipv6_cidr_block     = false
    cidr_block                           = "10.123.0.0/16"
    default_network_acl_id               = "acl-0ecc24f2a10f57b9a"
    default_route_table_id               = "rtb-07e2b419912b369dd"
    default_security_group_id            = "sg-05b56732b4670b4e5"
    dhcp_options_id                      = "dopt-07f948d3a0e8128a8"
    enable_dns_hostnames                 = true
    enable_dns_support                   = true
    enable_network_address_usage_metrics = false
    id                                   = "vpc-0968cbac5f4fb1eb0"
    instance_tenancy                     = "default"
    ipv6_netmask_length                  = 0
    main_route_table_id                  = "rtb-07e2b419912b369dd"
    owner_id                             = "113296392243"
    tags                                 = {
        "name" = "dev"
    }
    tags_all                             = {
        "name" = "dev"
    }
}

terraform destroy
terraform plan -destroy # speculative destroy plan

# Example new resource added on tf files on terraform plan
-> terraform plan
aws_vpc.our_vpc: Refreshing state... [id=vpc-0968cbac5f4fb1eb0]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_subnet.our_subnet will be created
  + resource "aws_subnet" "our_subnet" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-east-1"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.123.1.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = true
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "name" = "dev-public"
        }
      + tags_all                                       = {
          + "name" = "dev-public"
        }
      + vpc_id                                         = "vpc-0968cbac5f4fb1eb0"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

terraform apply -auto-approve

terraform fmt 


How to get AMI name : 
aws ec2 describe-images --image-ids ami-0e8a34246278c21e4


ssh-keygen -t ed25519
-> Enter file in which to save the key (C:\Users\dafas/.ssh/id_ed25519): C:\Users\dafas/.ssh/aws_key 

ls ~/.ssh

The key fingerprint is:
SHA256:hrp4bCmno/tU4Dml8zdqNjpXK5YbX54QnB0Y4Fkc2kU dafas@DESKTOP-I4U8C7E

ssh -i ~/.ssh/aws_key ec2-user@44.204.113.211

# Debug
ssh -i ~/.ssh/aws_key -v ec2-user@3.221.159.188

ssh -i ~/.ssh/aws_key -v ec2-user@44.204.113.21

# linux
terraform show | grep "private_ip"
# windows
terraform show | findstr private_ip
terraform show | findstr public_ip