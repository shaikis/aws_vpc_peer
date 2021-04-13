# aws_vpc_peer











# variables
- `peer_owner_id` - (Optional) The AWS account ID of the owner of the peer VPC. Defaults to the account ID the AWS provider is currently connected to.
- `peer_vpc_id` - (Required) The ID of the VPC with which you are creating the VPC Peering Connection.
- `vpc_id` - (Required) The ID of the requester VPC.
- `auto_accept` - (Optional) Accept the peering (both VPCs need to be in the same AWS account).