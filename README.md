# aws_vpc_peer
## Overview

A Terraform module to create a VPC peering connection with another VPC. This module only carries out work on one VPC (ie. it does not auto accept the peering creation).

This module will create the appropriate routes and add these to the routing tables of the VPC which will allow the peering connection to work as expected. Therefore this module has a dependancy on the `rap-terraform-vpc` module, as it can use the `aws_route_table.public_route_table` and `aws_route_table.private_route_table` outputs to run without much hassle. The routes will appear as `status = black hole` until the peering connection has been accepted and is active.

Once this module has been applied to a VPC, the module `aws-terraform-vpc-peer-accepter` should be configured on the peered account which represents the `peer_aws_vpc_id` variable. This request will stay open for 7days only, before being expired.

## Dependencies
 `Vpc module which provides subnets, Routetables,`
 
Once this module has been run the following should be used on the peered account/VPC:
 `terraform/vpc`
 `aws-terraform-vpc-peer-accepter`

## Usage
Import the module and retrieve with ```terraform get```.

```
module "vpc_peer" {
  source = "git::ssh://git@github.com:shaikis/aws_vpc_peer.git"

  global_aws_vpc = "vpc-abcd"
  vpc_peer_owner_id = "1112223334455"
  vpc_peer_aws_vpc_id = "vpc-a11b22c33"
  vpc_peer_name_tag = "shared-services"
  vpc_peer_environment_tag = "live"
  vpc_peer_product_tag = "infrastructure"
  vpc_peer_contact_tag ="shaik.urs@gmail.com"
  vpc_peer_peered_account_name ="aws-eht-ismailPersonal"
  vpc_peer_private_subnets = "10.111.220.0/22,10.111.224.0/22,10.111.228.0/22" (or) "data.pub_cidr.value" (to avoid hard coding in modules.)
  vpc_peer_public_subnets = "10.154.208.0/22,10.154.212.0/22,10.154.216.0/22" (or) "data.pub_cidr.value"
  vpc_peer_private_route_tables = "rtb-faf1234a,rtb-faf1234b,rtb-faf1234c" (or) "module.pub_route_tables.id, module.priv_route_tables.id"
  vpc_peer_public_route_tables = "rtb-faf1234d,rtb-faf1234e,rtb-faf1234f"
  vpc_peer_destination_cidr = "10.154.128.0/19"
}
```
### Required Variables
- `global_aws_vpc_id` - The ID of your VPC.
- `vpc_peer_owner_id` - The AWS account ID you wish to peer with.
- `vpc_peer_aws_vpc_id` - The ID of the VPC with which you are creating the VPC peering connection.
- `vpc_peer_name_tag` - The Name to give to the peering connection.
- `vpc_peer_environment_tag` - The environment of the peering connection.
- `vpc_peer_product_tag` - The product owner of the peering connection.
- `vpc_peer_contact_tag` - A valid email address to contact with queries of this peering connection.
- `vpc_peer_peered_account_name` - The name of the account you are peering to.
- `vpc_peer_private_subnets` - A comma delimited string of private subnets.
- `vpc_peer_public_subnets` - A comma delimited string of public subnets
- `vpc_peer_private_route_tables` - A comma delimited string of the private route table ids to add a peering route to.
- `vpc_peer_public_route_tables` - A comma delimited string of the public route table ids to add a peering route to.
- `vpc_peer_destination_cidr` - The CIDR block to peer with.

### Optional Variables
- `vpc_peer_auto_accept` - Automatically accept the peering connection between VPCs. VPCs must be in the same account. Default is `false`.

## Output Variables
- `peer_vpc_peering_connection_id` - The ID of the VPC Peering Connection

