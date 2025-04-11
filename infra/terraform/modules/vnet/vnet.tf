// vnet.tf

resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  address_space = [
    var.address_prefix
  ]
}
