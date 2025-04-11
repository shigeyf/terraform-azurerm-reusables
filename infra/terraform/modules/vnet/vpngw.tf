// vpngw.tf

module "vpngw" {
  count                    = var.enable_vpn_gateway ? 1 : 0
  source                   = "../vnet-vpngw"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  tags                     = var.tags
  vpngw_name               = var.vpn_gateway_name
  type                     = var.vpn_gateway_type
  vpn_type                 = var.vpn_gateway_vpn_type
  public_ip_name           = var.vpn_gateway_public_ip_name
  sku                      = var.vpn_gateway_sku
  vpn_client_address_space = var.vpn_gateway_client_address_space
  subnet_id                = azurerm_subnet.this[local.gateway_subnet_fixed_name].id
}
