// lock.tf

resource "azurerm_management_lock" "keyvault" {
  count      = var.enable_lock ? 1 : 0
  name       = "lock-${var.vnet_name}"
  scope      = azurerm_virtual_network.this.id
  lock_level = "CanNotDelete"
  notes      = "Locked to prevent accidental deletion of the resource"

  depends_on = [
    azurerm_virtual_network.this,
  ]
}
