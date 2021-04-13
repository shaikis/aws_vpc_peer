resource "aws_vpc_peering_connection" "vpc_peer_main" {
  peer_owner_id = var.peer_owner_id
  peer_vpc_id   = var.vpc_peer_aws_vpc_id
  vpc_id        = var.aws_global_vpc_id
  auto_accept   = var.vpc_peer_auto_accept

  tags = {
      Name        = var.vpc_peer_name_tag
      environment = var.vpc_peer_environment_tag
      contact     = var.vpc_peer_contact_tag
      Product     = var.vpc_peer_product_tag
      role        =  "peering_to_${var.vpc_peer_peered_account_name}_account"
  }
}