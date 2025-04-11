// private_endpoint.tf

resource "azurerm_private_endpoint" "this" {
  count               = var.enable_public_network_access ? 0 : 1
  name                = var.private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "connection-${azurerm_key_vault.this.id}"
    private_connection_resource_id = azurerm_key_vault.this.id
    is_manual_connection           = false
    subresource_names              = [local.subresource_name]
  }

  private_dns_zone_group {
    name                 = "dns-zone-group"
    private_dns_zone_ids = var.private_dns_zone_ids
  }

  depends_on = [
    azurerm_key_vault.this,
  ]
}
