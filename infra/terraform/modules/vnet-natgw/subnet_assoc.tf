// subnet_assoc.tf

resource "azurerm_subnet_nat_gateway_association" "this" {
  for_each       = var.subnets
  subnet_id      = each.value
  nat_gateway_id = azurerm_nat_gateway.this.id

  depends_on = [
    azurerm_nat_gateway.this,
  ]
}
