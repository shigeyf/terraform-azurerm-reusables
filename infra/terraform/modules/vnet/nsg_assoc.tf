// ngs_assoc.tf

resource "azurerm_subnet_network_security_group_association" "this" {
  # No NSG for GatewaySubnet
  for_each = { for index, subnet in var.subnets : index => subnet if subnet.name != local.gateway_subnet_fixed_name }

  subnet_id                 = azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.this[each.key].id

  depends_on = [
    azurerm_virtual_network.this,
    azurerm_subnet.this,
    azurerm_network_security_group.this,
  ]
}
