// natgw.tf

module "natgw" {
  count               = var.enable_nat_gateway ? 1 : 0
  source              = "../vnet-natgw"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  natgw_name          = var.nat_gateway_name
  public_ip_name      = var.nat_gateway_public_ip_name
  # No NAT GW association with GatewaySubnet
  subnets = {
    for index, subnet in azurerm_subnet.this : index => subnet.id
    if subnet.name != local.gateway_subnet_fixed_name
  }
}
