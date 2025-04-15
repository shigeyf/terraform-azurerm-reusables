// vpngw.tf

resource "azurerm_virtual_network_gateway" "this" {
  name                = var.vpngw_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  generation = var.generation
  sku        = var.sku
  type       = var.type
  vpn_type   = var.vpn_type

  active_active = var.active_active
  enable_bgp    = var.enable_bgp

  ip_configuration {
    name                          = "vpnGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.this.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet_id
  }

  dynamic "vpn_client_configuration" {
    for_each = length(var.vpn_client_address_space) != 0 ? [1] : []
    content {
      address_space = var.vpn_client_address_space
    }
  }

  depends_on = [
    azurerm_public_ip.this,
  ]
}
