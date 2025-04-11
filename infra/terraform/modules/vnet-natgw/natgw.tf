// natgw.tf

resource "azurerm_nat_gateway" "this" {
  name                = var.natgw_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  sku_name            = var.sku
}

resource "azurerm_nat_gateway_public_ip_association" "this" {
  nat_gateway_id       = azurerm_nat_gateway.this.id
  public_ip_address_id = azurerm_public_ip.this.id

  depends_on = [
    azurerm_public_ip.this,
    azurerm_nat_gateway.this,
  ]
}
