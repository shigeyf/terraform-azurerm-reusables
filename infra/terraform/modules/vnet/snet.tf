// snet.tf

resource "azurerm_subnet" "this" {
  for_each = var.subnets
  name = (
    each.value.naming_prefix_enabled
    ? "${var.subnet_name_prefix}-${each.value.name}"
    : each.value.name
  )
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [each.value.address_prefix]

  default_outbound_access_enabled = local.enable_default_outbound_access

  dynamic "delegation" {
    for_each = each.value.delegation != null ? each.value.delegation : []
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }

  depends_on = [
    azurerm_virtual_network.this,
  ]
}
