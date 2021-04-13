#----------------------------------------------
# Private subnet peering routes
#----------------------------------------------
resource "aws_route" "private_peering_route" {
  count                     = var.vpc_peer_private_subnets == "" ? "0" :  length(split(",", var.vpc_peer_private_subnets))
  route_table_id            = element(split(",", var.vpc_peer_private_route_tables), count.index)
  destination_cidr_block    = var.vpc_peer_destination_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_main.id
}

#-------------------------------------------------
#Public subnet peering routes
#-------------------------------------------------
resource "aws_route" "public_peering_route" {
  count                     = var.vpc_peer_public_subnets == "" ? "0" :  length(split(",", var.vpc_peer_public_subnets))
  route_table_id            = element(split(",", var.vpc_peer_public_route_tables), count.index)
  destination_cidr_block    = var.vpc_peer_destination_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_main.id
}